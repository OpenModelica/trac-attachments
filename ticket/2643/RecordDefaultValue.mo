model RecordDefaultValue

  record MyRecord
    Real a;
    Real b=24;
  end MyRecord;

  MyRecord r=MyRecord(time,-time);
end RecordDefaultValue;