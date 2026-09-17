#!/usr/bin/env python

import threading
import matplotlib.pyplot as plt
from pyparsing import *

def convertNumbers(s,l,toks):
    n = toks[0]
    try:
        return int(n)
    except ValueError as ve:
        return float(n)
def convertString(s,s2):
  return s2[0].replace("\\\"",'"')
def convertDict(d):
    return dict(d[0])
def convertTuple(t):
    return tuple(t[0])

omcRecord = Forward()
omcValue = Forward()

TRUE = Keyword("true").setParseAction( replaceWith(True) )
FALSE = Keyword("false").setParseAction( replaceWith(False) )
NONE = (Keyword("NONE") + Suppress("(") + Suppress(")") ).setParseAction( replaceWith(None) )
SOME = (Suppress( Keyword("SOME") ) + Suppress("(") + omcValue + Suppress(")") )

omcString = QuotedString(quoteChar='"',escChar='\\', multiline = True).setParseAction( convertString )
omcNumber = Combine( Optional('-') + ( '0' | Word('123456789',nums) ) +
                    Optional( '.' + Word(nums) ) +
                    Optional( Word('eE',exact=1) + Word(nums+'+-',nums) ) )

ident = Word(alphas+"_",alphanums+"_") | Combine( "'" + Word(alphanums+"!#$%&()*+,-./:;<>=?@[]^{}|~ ") + "'" )
fqident = Forward()
fqident << ( (ident + "." + fqident) | ident )
omcValues = delimitedList( omcValue )
omcTuple = Group( Suppress('(') + Optional(omcValues) + Suppress(')') ).setParseAction(convertTuple)
omcArray = Group( Suppress('{') + Optional(omcValues) + Suppress('}') ).setParseAction(convertTuple)
omcValue << ( omcString | omcNumber | omcRecord | omcArray | omcTuple | SOME | TRUE | FALSE | NONE | Combine(fqident) )
recordMember = delimitedList( Group( ident + Suppress('=') + omcValue ) )
omcRecord << Group( Suppress('record') + Suppress( fqident ) +  Dict( recordMember ) + Suppress('end') + Suppress( fqident ) + Suppress(';') ).setParseAction(convertDict)

omcGrammar = omcValue + StringEnd()

omcNumber.setParseAction( convertNumbers )

def parseString(string):
  return omcGrammar.parseString(string)[0]

if __name__ == "__main__":
  parseString(open("tmp.file", "r").read())
