within BatteryEmulator;
model StateOfCharge
  Modelica.Electrical.Analog.Basic.VariableCapacitor
                                             StateOfCharge(v(fixed=true, start=
          SOCinit))        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-40})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-84},{0,-64}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={50,-40})));
  Modelica.Blocks.Interfaces.RealInput ChargingCurrent
    annotation (Placement(transformation(extent={{-126,20},{-86,60}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,-40})));
  Modelica.Blocks.Interfaces.RealOutput SOC
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  parameter Modelica.Units.SI.Capacitance Cq=27.625*3600
    "Capacity of the battery";
  parameter Modelica.Units.SI.Voltage SOCinit=1 - 15.6845/27.625
    "Initial SOC value";
  Modelica.Blocks.Interfaces.RealInput Temperature
    annotation (Placement(transformation(extent={{-126,-60},{-86,-20}})));
  Modelica.Blocks.Tables.CombiTable1Dv combiTable1D(table=[278.15,28.0081;
        293.15,27.625; 313.15,27.6392])
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Math.Gain gain(k=3600)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
equation
//   assert(SOC>=0 and SOC<=1, "State of battery charge must be
//   between 0 and 1", level = AssertionLevel.error);
  connect(StateOfCharge.n, signalCurrent.p) annotation (Line(points={{-10,-50},
          {-10,-60},{50,-60},{50,-50}},
                              color={0,0,255}));
  connect(StateOfCharge.n, ground.p)
    annotation (Line(points={{-10,-50},{-10,-64}}, color={0,0,255}));
  connect(voltageSensor.p, signalCurrent.n) annotation (Line(points={{20,-30},
          {20,-20},{50,-20},{50,-30}}, color={0,0,255}));
  connect(voltageSensor.n, signalCurrent.p) annotation (Line(points={{20,-50},
          {20,-60},{50,-60},{50,-50}}, color={0,0,255}));
  connect(StateOfCharge.p, signalCurrent.n) annotation (Line(points={{-10,-30},
          {-10,-20},{50,-20},{50,-30}}, color={0,0,255}));
  connect(voltageSensor.v, SOC) annotation (Line(points={{31,-40},{38,-40},{
          38,0},{108,0}}, color={0,0,127}));
  connect(Temperature, combiTable1D.u[1])
    annotation (Line(points={{-106,-40},{-82,-40}}, color={0,0,127}));
  connect(StateOfCharge.C, gain.y)
    annotation (Line(points={{-22,-40},{-29,-40}}, color={0,0,127}));
  connect(combiTable1D.y[1], gain.u)
    annotation (Line(points={{-59,-40},{-52,-40}}, color={0,0,127}));
  connect(ChargingCurrent, signalCurrent.i) annotation (Line(points={{-106,40},
          {62,40},{62,-40}},                  color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end StateOfCharge;
