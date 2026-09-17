within ;
package FlexBeamPackage "FEM exported package"

  model FlexBeam
    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    import Modelica.Math.*;
    parameter Integer N = 2 "Number of elements";
    parameter Integer M = 3 * N;
    parameter Real q_start[M] = zeros(M) "Initialization||Initial deformation";
    parameter Real dq_start[M] = zeros(M)
      "Initialization||Initial velocity of deformation";
    parameter SI.Length L "Beam Length";
    parameter SI.Density rho "Material Volume Density";
    parameter SI.Area A "Cross sectional area";
    parameter Real d "Damping coefficient";
    parameter SI.ModulusOfElasticity E "Material Youngs modulus";
    parameter SI.SecondMomentOfArea J "Cross sectional inertia";
    parameter Boolean ClampedFree = true
      "if true Clamped-Free else simply supported model";
    parameter Boolean CircularSection = true
      "if true the beam has circular section";
    parameter Modelica.Mechanics.MultiBody.Types.Color ColorBeam = {128, 0, 0}
      "|3D Graphics|| Beam color ";
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a FrameA annotation(Placement(transformation(extent = {{-116, -12}, {-84, 20}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b FrameB annotation(Placement(transformation(extent = {{84, -12}, {116, 20}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Frames.Orientation R_rel;
    Real q[M](start = q_start,fixed=true) "Elastic coordinates";
    Real dq[M](start = dq_start,fixed=true) "Elastic velocities";
    Real ddq[M] "Elastic accelerations";
    Real h_w_r[3, 1];
    Real h_w_theta[3, 1];
    Real h_w_f[M, 1];
    Real h_e_r[3, 1];
    Real h_e_theta[3, 1];
    Real h_e_f[M, 1];
    Real ra_w[3];
    Real r_cm_w[3];
    Real va_a[3];
    Real v_0a[3];
    Real aa_a[3];
    Real wa_a[3];
    Real za_a[3];
    Real fa[3];
    Real taua[3];
    Real rb_w[3];
    Real fb[3];
    Real taub[3];
    Real fb_a[3];
    Real taub_a[3];
    //terms for energy calculations
    Real MassMat[M + 6, M + 6];
    Real coords[M + 6];
    Real KinEnergy;
    Real PotEnergy;
    Real TotalEnergy;
    parameter Real m = rho * A * L;
    parameter Real r0b[3] = {L, 0, 0};
    parameter Real Cm[3] = {L / 2, 0, 0};
    final parameter Real h = L / N;
    final parameter Real KffEl[6, 6] = E * [A / h, 0, 0, -A / h, 0, 0; 0, 12 * J / h ^ 3, 6 * J / h ^ 2, 0, -12 * J / h ^ 3, 6 * J / h ^ 2; 0, 6 * J / h ^ 2, 4 * J / h, 0, -6 * J / h ^ 2, 2 * J / h; -A / h, 0, 0, A / h, 0, 0; 0, -12 * J / h ^ 3, -6 * J / h ^ 2, 0, 12 * J / h ^ 3, -6 * J / h ^ 2; 0, 6 * J / h ^ 2, 2 * J / h, 0, -6 * J / h ^ 2, 4 * J / h];
    final parameter Real SbarEl[3, 6] = m / N / 12 * [6, 0, 0, 6, 0, 0; 0, 6, h, 0, 6, -h; 0, 0, 0, 0, 0, 0];
    final parameter Real Sbar11[6, 6] = m / N * [1 / 3, 0, 0, 1 / 6, 0, 0; 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0; 1 / 6, 0, 0, 1 / 3, 0, 0; 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0];
    final parameter Real Sbar12[6, 6] = transpose(Sbar21);
    final parameter Real Sbar13[6, 6] = zeros(6, 6);
    final parameter Real Sbar21[6, 6] = m / N * [0, 0, 0, 0, 0, 0; 7 / 20, 0, 0, 3 / 20, 0, 0; 1 / 20 * h, 0, 0, 1 / 30 * h, 0, 0; 0, 0, 0, 0, 0, 0; 3 / 20, 0, 0, 7 / 20, 0, 0; -1 / 30 * h, 0, 0, -1 / 20 * h, 0, 0];
    final parameter Real Sbar22[6, 6] = m / N * [0, 0, 0, 0, 0, 0; 0, 13 / 35, 11 / 210 * h, 0, 9 / 70, -13 / 420 * h; 0, 11 / 210 * h, 1 / 105 * h ^ 2, 0, 13 / 420 * h, -1 / 140 * h ^ 2; 0, 0, 0, 0, 0, 0; 0, 9 / 70, 13 / 420 * h, 0, 13 / 35, -11 / 210 * h; 0, -13 / 420 * h, -1 / 140 * h ^ 2, 0, -11 / 210 * h, 1 / 105 * h ^ 2];
    final parameter Real Sbar23[6, 6] = zeros(6, 6);
    final parameter Real Sbar31[6, 6] = zeros(6, 6);
    final parameter Real Sbar32[6, 6] = zeros(6, 6);
    final parameter Real Sbar33[6, 6] = zeros(6, 6);
    final parameter Real Ibar11[1, 6] = h * m / N * [1 / 6, 0, 0, 1 / 3, 0, 0]
                                                                              annotation(Evaluate=true);
    final parameter Real Ibar11adj[1, 6] = h * m / N * [1 / 2, 0, 0, 1 / 2, 0, 0] annotation(Evaluate=true);
    final parameter Real Ibar12[1, 6] = h * m / N * [0, 3 / 20, 1 / 30 * h, 0, 7 / 20, -1 / 20 * h] annotation(Evaluate=true);
    final parameter Real Ibar12adj[1, 6] = h * m / N * [0, 1 / 2, 1 / 12 * h, 0, 1 / 2, -1 / 12 * h] annotation(Evaluate=true);
    final parameter Real Ibar13[1, 6] = zeros(1, 6);
    final parameter Real Ibar21[1, 6] = zeros(1, 6);
    final parameter Real Ibar22[1, 6] = zeros(1, 6);
    final parameter Real Ibar23[1, 6] = zeros(1, 6);
    final parameter Real Ibar31[1, 6] = zeros(1, 6);
    final parameter Real Ibar32[1, 6] = zeros(1, 6);
    final parameter Real Ibar33[1, 6] = zeros(1, 6);
    final parameter Real S0[3, 6] = [1, 0, 0, 0, 0, 0; 0, 1, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0];
    final parameter Real dS0[3, 6] = [0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0; 0, 0, 1, 0, 0, 0];
    final parameter Real S1[3, 6] = [0, 0, 0, 1, 0, 0; 0, 0, 0, 0, 1, 0; 0, 0, 0, 0, 0, 0];
    final parameter Real S2[3, 6] = [0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 1, 0; 0, 0, 0, 0, 0, 0];
    final parameter Real dS1[3, 6] = [0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 1];
    SI.Acceleration g_0[3] "Gravity acc. vector resolved in world frame";
    //matrici di connettivita
    Real B[N, 6, M];
    //matrice di forma del connettore B, � variabile perch� dipende dalle condizioni al contorno dell'asta
    Real Sb[3, M];
    Real SbCap[3, M];
    Real Ke[M, M];
    Real Me[M, M];
    Real Ct[M, 3];
    Real Sbar[3, M];
    Real Stbar[3];
    Real mDcbar[3];
    Real mDcbartilde[3, 3];
    Real Ithf_bar[3, M];
    Real Cr[M, 3];
    Real Ithth_bar[3, 3];
    Real Ithth_bar11;
    Real Ithth_bar22;
    Real Ithth_bar33;
    Real Ithth_bar12;
    Real Jbar[3, 3];
    //per il calcolo di h_w_f
    Real F[6, 6];
    Real H[6, 6];
    Real wCross[3, 3];
    Real wCross2[3, 3];
  protected
    outer Modelica.Mechanics.MultiBody.World world;
    /* 3D graphics variables */
    type vec3D = Real[3];
    vec3D r0shape[N];
    vec3D rrelshape[N];
    Real Lshape[N];
    parameter Real pi = Modelica.Constants.pi;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape Segment[N](r_shape = r0shape, length = Lshape, each width = if CircularSection then 2 * sqrt(A / pi) else A / (0.4 * sqrt(A)), each height = if CircularSection then 2 * sqrt(A / pi) else 0.4 * sqrt(A), lengthDirection = rrelshape, each widthDirection = {0, 0, 1}, each shapeType = if CircularSection then "cylinder" else "box", each color = ColorBeam, each extra = 0.0, each r = FrameA.r_0, each R = FrameA.R);
  equation
    Connections.branch(FrameA.R, FrameB.R);
    assert(cardinality(FrameA) > 0 or cardinality(FrameB) > 0, "Frames both disconnected, object floating!");
    //connectivity matrices calculus, in beam model connectivity matrixes determinate boundary conditions
    if ClampedFree then
      B[1, :, :] = [zeros(3, 3 * N); identity(3), zeros(3, 3 * (N - 1))];
      B[N, :, :] = [zeros(6, 3 * (N - 2)), identity(6)];
    else
      B[1, :, :] = [zeros(2, 3 * N); [zeros(1, 3 * (N - 1)), [0, 1, 0]]; identity(3), zeros(3, 3 * (N - 1))];
      B[N, :, :] = [zeros(3, 3 * (N - 2)), identity(3), zeros(3, 3); zeros(3, 3 * (N - 2)), zeros(3, 3), [1, 0, 0; 0, 0, 0; 0, 0, 1]];
    end if;
    for i in 2:N - 1 loop
      B[i, :, :] = [zeros(6, 3 * (i - 2)), identity(6), zeros(6, 3 * (N - i))];
    end for;
    /* calcolo dei componenti della matrice di inerzia */
    /*-----------------------*/
    //Sbar in modello beam equivale a Ct trasposto in FEM
    Sbar = sum(SbarEl * B[i, :, :] for i in 1:N);
    Ct = transpose(Sbar);
    //Stbar equivale a mDcbar
    Stbar = m * Cm + Sbar * q;
    mDcbar = Stbar;
    mDcbartilde = skew(mDcbar);
    //Ithf_bar equivale a Cr trasposto
    Ithf_bar = [zeros(2, 3 * N); sum((Ibar12 + (i - 1) * Ibar12adj + transpose(matrix(q)) * transpose(B[i, :, :]) * (Sbar12 - Sbar21)) * B[i, :, :] for i in 1:N)];
    Cr = transpose(Ithf_bar);
    //Ithth equivale a Jbar
    //ATTENZIONE per calcolare Ithth_bar � necessario calcolare molte quantit�
    Ithth_bar11 = scalar(transpose(matrix(q)) * sum(transpose(B[i, :, :]) * Sbar22 * B[i, :, :] for i in 1:N) * q);
    Ithth_bar22 = m * L ^ 2 / 3 + scalar(2 * sum((Ibar11 + (i - 1) * Ibar11adj) * B[i, :, :] for i in 1:N) * q + transpose(matrix(q)) * sum(transpose(B[i, :, :]) * Sbar11 * B[i, :, :] for i in 1:N) * q);
    Ithth_bar33 = Ithth_bar11 + Ithth_bar22;
    Ithth_bar12 = scalar((-sum((Ibar12 + (i - 1) * Ibar12adj) * B[i, :, :] for i in 1:N) * q) - transpose(matrix(q)) * sum(transpose(B[i, :, :]) * Sbar21 * B[i, :, :] for i in 1:N) * q);
    Ithth_bar = [Ithth_bar11, Ithth_bar12, 0; Ithth_bar12, Ithth_bar22, 0; 0, 0, Ithth_bar33];
    Jbar = Ithth_bar;
    //credo di poterlo calcolare come der(Jbar)
    //mff equivale a Me
    Me = sum(transpose(B[i, :, :]) * (Sbar11 + Sbar22) * B[i, :, :] for i in 1:N);
    //kff equivale a Ke
    Ke = sum(transpose(B[i, :, :]) * KffEl * B[i, :, :] for i in 1:N);
    r_cm_w = FrameA.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(FrameA.R, Cm);
    g_0 = Modelica.Mechanics.MultiBody.Frames.resolve2(FrameA.R, world.gravityAcceleration(r_cm_w));
    ra_w = FrameA.r_0;
    va_a = Modelica.Mechanics.MultiBody.Frames.resolve2(FrameA.R, der(FrameA.r_0));
    v_0a = der(ra_w);
    aa_a = Modelica.Mechanics.MultiBody.Frames.resolve2(FrameA.R, der(v_0a));
    wa_a = Modelica.Mechanics.MultiBody.Frames.angularVelocity2(FrameA.R);
    za_a = der(wa_a);
    fa = FrameA.f;
    taua = FrameA.t;
    rb_w = FrameB.r_0;
    fb = FrameB.f;
    taub = FrameB.t;
    //Relation between A and B DYNAMIC positions, must write equations for translation AND rotation
    //translation
    rb_w = ra_w + Modelica.Mechanics.MultiBody.Frames.resolve1(FrameA.R, r0b + Sb * q);
    //Devo definire l'orientamento di B rispetto al world frame
    R_rel = Modelica.Mechanics.MultiBody.Frames.planarRotation({0, 0, 1}, q[M], dq[M]);
    FrameB.R = Modelica.Mechanics.MultiBody.Frames.absoluteRotation(FrameA.R, R_rel);
    //forces and torques on B expressed in A
    fb_a = Modelica.Mechanics.MultiBody.Frames.resolve1(R_rel, fb);
    taub_a = Modelica.Mechanics.MultiBody.Frames.resolve1(R_rel, taub);
    dq = der(q);
    ddq = der(dq);
    //coriolis terms calculus
    h_w_r = matrix((-cross(wa_a, cross(wa_a, mDcbar))) - 2 * cross(wa_a, transpose(Ct) * dq));
    h_w_theta = matrix((-cross(wa_a, Jbar * wa_a)) - der(Jbar) * wa_a - cross(wa_a, transpose(Cr) * dq));
    wCross = skew(wa_a);
    wCross2 = wCross * wCross;
    F = Sbar11 * wCross2[1, 1] + Sbar12 * wCross2[2, 1] + Sbar21 * wCross2[1, 2] + Sbar22 * wCross2[2, 2];
    H = Sbar11 * wCross[1, 1] + Sbar12 * wCross[2, 1] + Sbar21 * wCross[1, 2] + Sbar22 * wCross[2, 2];
    h_w_f = -sum(transpose(B[i, :, :]) * transpose([(Ibar11 + (i - 1) * Ibar11adj) * wCross2[1, 1] + (Ibar12 + (i - 1) * Ibar12adj) * wCross2[2, 1]]) + matrix(transpose(B[i, :, :]) * F * B[i, :, :] * q) + matrix(2 * (transpose(B[i, :, :]) * H * B[i, :, :]) * dq) for i in 1:N);
    h_e_r = matrix(fa + fb_a);
    h_e_theta = matrix(taua + taub_a + cross(r0b + Sb * q, fb_a));
    transpose(h_e_f) = transpose(matrix(fb_a)) * S1 * B[N, :, :] + transpose(matrix(taub_a)) * dS1 * B[N, :, :];
    Sb = S1 * B[N, :, :];
    SbCap = dS1 * B[N, :, :];
    /*---Dynamic equations---*/
    //rigid traslation
    [m * identity(3), transpose(mDcbartilde), transpose(Ct)] * [aa_a - g_0; za_a; ddq] = h_w_r + h_e_r;
    //rigid rotation
    [mDcbartilde, Jbar, transpose(Cr)] * [aa_a - g_0; za_a; ddq] = h_w_theta + h_e_theta;
    //flexible modal dynamic equations
    [Ct, Cr, Me] * [aa_a - g_0; za_a; ddq] = h_w_f + h_e_f - matrix(Ke * q) - matrix(d / 100 * (Me + 0.5 * Ke) * dq);
    //Conservation of Energy
    MassMat = [m * identity(3), transpose(mDcbartilde), transpose(Ct); mDcbartilde, Jbar, transpose(Cr); Ct, Cr, Me];
    coords = vector([va_a; wa_a; dq]);
    KinEnergy = scalar(0.5 * transpose(matrix(coords)) * MassMat * matrix(coords));
    PotEnergy = world.g * m * r_cm_w[2] + 0.5 * scalar(transpose(matrix(q)) * Ke * matrix(q));
    TotalEnergy = KinEnergy + PotEnergy;
    /* 3D Visual Representation */
    r0shape[1, :] = {0, 0, 0};
    rrelshape[1, :] = r0shape[2, :];
    Lshape[1] = sqrt(rrelshape[1, :] * rrelshape[1, :]);
    r0shape[N, :] = {L * (N - 1) / N, 0, 0} + S1 * B[N - 1, :, :] * q;
    rrelshape[N, :] = {L, 0, 0} + S1 * B[N, :, :] * q - r0shape[N, :];
    Lshape[N] = sqrt(rrelshape[N, :] * rrelshape[N, :]);
    for i in 2:N - 1 loop
      r0shape[i, :] = {L * (i - 1) / N, 0, 0} + S1 * B[i - 1, :, :] * q;
      rrelshape[i, :] = r0shape[i + 1, :] - r0shape[i, :];
      Lshape[i] = sqrt(rrelshape[i, :] * rrelshape[i, :]);
    end for;
    annotation(Diagram(graphics), Icon(graphics={  Text(extent = {{-118, 102}, {114, 38}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "%name"), Rectangle(extent = {{-98, 46}, {96, -40}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
              fillPattern =                                                                                                    FillPattern.Solid)}), DymolaStoredErrors);
  end FlexBeam;




  package ExamplesBeam
    model FreeVibrationBeam

      FlexBeamPackage.FlexBeam fEMBeam(
        CircularSection=true,
        L=2,
        N=2,
        rho=2767,
        A=0.01*0.01*3.1415,
        E=7.2e10,
        d=1,
        J=Modelica.Constants.pi*0.01^4/4) annotation (Placement(transformation(
              extent={{-8,-18},{12,2}}, rotation=0)));
      inner Modelica.Mechanics.MultiBody.World world annotation(Placement(transformation(extent = {{-74, -18}, {-54, 2}}, rotation = 0)));
      Modelica.Mechanics.MultiBody.Parts.Body body(sphereDiameter = 0.1, sphereColor = {255, 0, 0}, m = 0,
        r_CM={0,0,0})                                                                                      annotation(Placement(transformation(extent = {{50, -18}, {70, 2}}, rotation = 0)));
    equation
      connect(world.frame_b, fEMBeam.FrameA) annotation(Line(points = {{-54, -8}, {-28, -8}, {-28, -7.6}, {-8, -7.6}}, color = {95, 95, 95}, thickness = 0.5));
      connect(fEMBeam.FrameB, body.frame_a) annotation(Line(points = {{12, -7.6}, {32, -7.6}, {32, -8}, {50, -8}}, color = {95, 95, 95}, thickness = 0.5));
      annotation(Diagram(graphics));
    end FreeVibrationBeam;

    model PendulumBeam
      parameter Real b_length=0.4;
      parameter Integer N=2;
      parameter Integer M=3*10;
      inner Modelica.Mechanics.MultiBody.World world annotation(Placement(transformation(extent = {{-92, 8}, {-72, 28}}, rotation = 0)));
      FlexBeamPackage.FlexBeam fEMBeam(
        CircularSection=true,
        N=10,
        L=b_length,
        A=0.0239*0.0239*Modelica.Constants.pi,
        d=0,
        E=4.7124e7,
        J=Modelica.Constants.pi*0.0239^4/4,
        rho=5.54e3,
        q_start=zeros(M),
        dq_start=zeros(M)) annotation (Placement(transformation(extent={{6,4},{
                32,30}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute(phi(fixed=true, start=0),
          w(fixed=true, start=0))                           annotation(Placement(transformation(extent = {{-42, 10}, {-22, 30}})));
      Modelica.Mechanics.MultiBody.Parts.Body body(m = 0, I_11 = 0, I_22 = 0, I_33 = 0,
        r_CM={b_length,0,0})                                                            annotation(Placement(transformation(extent = {{66, 8}, {86, 28}})));
    equation
      connect(world.frame_b, revolute.frame_a) annotation(Line(points = {{-72, 18}, {-58, 18}, {-58, 20}, {-42, 20}}, color = {95, 95, 95}, thickness = 0.5, smooth = Smooth.None));
      connect(revolute.frame_b, fEMBeam.FrameA) annotation(Line(points = {{-22, 20}, {-8, 20}, {-8, 17.52}, {6, 17.52}}, color = {95, 95, 95}, thickness = 0.5, smooth = Smooth.None));
      connect(fEMBeam.FrameB, body.frame_a) annotation(Line(points = {{32, 17.52}, {50, 17.52}, {50, 18}, {66, 18}}, color = {95, 95, 95}, thickness = 0.5, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                         graphics));
    end PendulumBeam;


  end ExamplesBeam;

  annotation(uses(Modelica(version = "3.2.1")));
end FlexBeamPackage;
