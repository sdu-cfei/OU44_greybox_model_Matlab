within BatteryEmulator;
model EquivalentCircuitTerminals
                               //3.691286353, 0.7244
  Modelica.Electrical.Analog.Sources.SignalVoltage   signalVoltage
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,-30})));
  Modelica.Electrical.Analog.Basic.VariableResistor
                                            R1(useHeatPort=false)
    annotation (Placement(transformation(extent={{-30,-2},{-10,-22}})));
  Modelica.Electrical.Analog.Basic.VariableCapacitor
                                             C1(IC=0,      UIC=true)
    annotation (Placement(transformation(extent={{-30,4},{-10,24}})));
  Modelica.Electrical.Analog.Basic.VariableResistor
                                            R0(useHeatPort=false)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-30})));
  Modelica.Blocks.Tables.CombiTable2Ds R1_lookup(table=[0,278.15,293.15,
        313.15; 0,0.01090,0.00290,0.00130; 0.1,0.00690,0.00240,0.00120; 0.25,
        0.00470,0.00260,0.00130; 0.5,0.00340,0.00160,1e-3; 0.75,0.00330,
        0.00230,0.00140; 0.9,0.0330,0.00180,0.00110; 1,0.0280,0.00170,0.00110])
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-40})));
  Modelica.Blocks.Tables.CombiTable2Ds v_lookup(table=[0,278.15,293.15,313.15;
        0,3.4966,3.5057,3.5148; 0.1,3.5519,3.566,3.5653; 0.25,3.6183,3.6337,
        3.6402; 0.5,3.7066,3.7127,3.7213; 0.75,3.9131,3.9259,3.9376; 0.9,
        4.0748,4.0777,4.0821; 1,4.1923,4.1928,4.193])
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Modelica.Blocks.Tables.CombiTable2Ds C1_lookup(table=[0,278.15,293.15,
        313.15; 0,1913.6,12447,30609; 0.1,4625.7,18872,32995; 0.25,23306,
        40764,47535; 0.5,10736,18721,26325; 0.75,18036,33630,48274; 0.9,12251,
        18360,26839; 1,9022.9,23394,30606])
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Blocks.Interfaces.RealInput SOC
    annotation (Placement(transformation(extent={{-124,50},{-84,90}})));
  Modelica.Blocks.Interfaces.RealInput Temperature
    annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
  Modelica.Blocks.Tables.CombiTable2Ds R0_lookup(table=[0,278.15,293.15,
        313.15; 0,0.01170,0.00850,0.0090; 0.1,0.01100,0.00850,0.0090; 0.25,
        0.01140,0.00870,0.00920; 0.5,0.01070,0.00820,0.00880; 0.75,0.01070,
        0.00830,0.00910; 0.9,0.01130,0.00850,0.00890; 1,0.01160,0.00850,
        0.00890]) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,64})));
  Modelica.Blocks.Interfaces.RealOutput OutputVoltage
    annotation (Placement(transformation(extent={{98,-40},{118,-20}})));
  Modelica.Blocks.Interfaces.RealOutput ThermalPower
    annotation (Placement(transformation(extent={{98,10},{118,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=R0.LossPower + R1.LossPower)
    annotation (Placement(transformation(extent={{26,8},{86,32}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,56})));
  Modelica.Blocks.Interfaces.RealOutput ChargingCurrent
    annotation (Placement(transformation(extent={{98,46},{118,66}})));
equation
  connect(R1.p, C1.p) annotation (Line(points={{-30,-12},{-40,-12},{-40,14},{
          -30,14}}, color={0,0,255}));
  connect(R1.n, R0.p) annotation (Line(points={{-10,-12},{0,-12},{0,0},{10,0}},
                    color={0,0,255}));
  connect(C1.n, R0.p) annotation (Line(points={{-10,14},{0,14},{0,0},{10,0}},
                    color={0,0,255}));
  connect(signalVoltage.p, C1.p) annotation (Line(points={{-50,-20},{-50,0},{
          -40,0},{-40,14},{-30,14}}, color={0,0,255}));
  connect(C1_lookup.y, C1.C)
    annotation (Line(points={{-29,80},{-20,80},{-20,26}}, color={0,0,127}));
  connect(signalVoltage.v, v_lookup.y)
    annotation (Line(points={{-62,-30},{-69,-30}}, color={0,0,127}));
  connect(R1.R, R1_lookup.y)
    annotation (Line(points={{-20,-24},{-20,-29}}, color={0,0,127}));
  connect(SOC, C1_lookup.u1) annotation (Line(points={{-104,70},{-76,70},{-76,
          86},{-52,86}}, color={0,0,127}));
  connect(Temperature, C1_lookup.u2) annotation (Line(points={{-104,0},{-82,0},
          {-82,74},{-52,74}}, color={0,0,127}));
  connect(v_lookup.u1, SOC) annotation (Line(points={{-92,-24},{-96,-24},{-96,
          -8},{-76,-8},{-76,70},{-104,70}}, color={0,0,127}));
  connect(v_lookup.u2, Temperature) annotation (Line(points={{-92,-36},{-100,
          -36},{-100,-12},{-82,-12},{-82,0},{-104,0}}, color={0,0,127}));
  connect(R0_lookup.y, R0.R)
    annotation (Line(points={{11,64},{20,64},{20,12}}, color={0,0,127}));
  connect(R0_lookup.u1, SOC)
    annotation (Line(points={{-12,70},{-104,70}}, color={0,0,127}));
  connect(R0_lookup.u2, Temperature) annotation (Line(points={{-12,58},{-58,
          58},{-58,0},{-104,0}}, color={0,0,127}));
  connect(R1_lookup.u1, SOC) annotation (Line(points={{-26,-52},{-26,-58},{
          -44,-58},{-44,70},{-104,70}}, color={0,0,127}));
  connect(R1_lookup.u2, Temperature) annotation (Line(points={{-14,-52},{-14,
          -68},{-66,-68},{-66,0},{-104,0}}, color={0,0,127}));
  connect(OutputVoltage, voltageSensor.v) annotation (Line(points={{108,-30},
          {61,-30}},                                     color={0,0,127}));
  connect(voltageSensor.p, R0.n)
    annotation (Line(points={{50,-20},{50,0},{30,0}}, color={0,0,255}));
  connect(realExpression.y, ThermalPower)
    annotation (Line(points={{89,20},{108,20}}, color={0,0,127}));
  connect(currentSensor.i, ChargingCurrent)
    annotation (Line(points={{61,56},{108,56}}, color={0,0,127}));
  connect(currentSensor.p, pin_p)
    annotation (Line(points={{50,66},{50,98},{0,98}}, color={0,0,255}));
  connect(currentSensor.n, voltageSensor.p)
    annotation (Line(points={{50,46},{50,-20}}, color={0,0,255}));
  connect(signalVoltage.n, voltageSensor.n) annotation (Line(points={{-50,-40},
          {-50,-64},{50,-64},{50,-40}}, color={0,0,255}));
  connect(pin_n, voltageSensor.n) annotation (Line(points={{0,-100},{0,-76},{
          50,-76},{50,-40}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EquivalentCircuitTerminals;
