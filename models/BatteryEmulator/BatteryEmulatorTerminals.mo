within BatteryEmulator;
model BatteryEmulatorTerminals
  import BatteryEmulatorTerminals;
  EquivalentCircuitTerminals equivalentCircuitTerminals
    annotation (Placement(transformation(extent={{-26,-80},{24,-26}})));
  ThermalExchange thermalExchange(
    cell_area=cell_area,
    h_conv=h_conv,
    cell_mass=cell_mass,
    cell_Cp_heat=cell_Cp_heat,
    C=C) annotation (Placement(transformation(extent={{34,-28},{70,-8}})));
  StateOfCharge stateOfCharge(Cq=27.625*3600, SOCinit=1 - 15.6845/27.625)
    annotation (Placement(transformation(extent={{10,28},{-28,52}})));
  Modelica.Blocks.Interfaces.RealInput AmbientTemperature
    annotation (Placement(transformation(extent={{-124,-40},{-84,0}})));
  Modelica.Blocks.Interfaces.RealOutput BatterySOC
    annotation (Placement(transformation(extent={{98,50},{118,70}})));
  Modelica.Blocks.Interfaces.RealOutput CircuitTemperature
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  Modelica.Blocks.Interfaces.RealOutput BatteryVoltage
    annotation (Placement(transformation(extent={{98,-70},{118,-50}})));

  parameter Real h_conv=5, cell_area=0.101908;
  parameter Modelica.Units.SI.Mass cell_mass=1;
  parameter Modelica.Units.SI.SpecificHeatCapacity cell_Cp_heat=810.5328;

  parameter Modelica.Units.SI.Capacitance Cq=27.625*3600
    "Capacity of the battery";
  parameter Modelica.Units.SI.Voltage SOCinit=1 - 15.6845/27.625
    "Initial SOC value";
  parameter Modelica.Units.SI.HeatCapacity C=1*810.5328
    "Heat capacity of the battery (= cp*m)";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
equation
  connect(equivalentCircuitTerminals.ThermalPower, thermalExchange.P_in)
    annotation (Line(points={{26,-47.6},{32,-47.6},{32,-30},{33.28,-30},{
          33.28,-26}}, color={0,0,127}));
  connect(stateOfCharge.SOC, equivalentCircuitTerminals.SOC) annotation (Line(
        points={{-29.52,40},{-42,40},{-42,-34},{-36,-34},{-36,-34.1},{-27,
          -34.1}}, color={0,0,127}));
  connect(thermalExchange.BatteryTemperature, equivalentCircuitTerminals.Temperature)
    annotation (Line(points={{71.08,-18},{76,-18},{76,-88},{-38,-88},{-38,-53},
          {-27,-53}}, color={0,0,127}));
  connect(stateOfCharge.Temperature, thermalExchange.BatteryTemperature)
    annotation (Line(points={{11.14,35.2},{78,35.2},{78,-18},{71.08,-18}},
        color={0,0,127}));
  connect(AmbientTemperature, thermalExchange.AmbientTemperature)
    annotation (Line(points={{-104,-20},{33.28,-20}}, color={0,0,127}));
  connect(CircuitTemperature, thermalExchange.BatteryTemperature) annotation (
      Line(points={{108,0},{88,0},{88,-18},{71.08,-18}}, color={0,0,127}));
  connect(stateOfCharge.SOC, BatterySOC) annotation (Line(points={{-29.52,40},{-42,
          40},{-42,60},{108,60}}, color={0,0,127}));
  connect(BatteryVoltage, equivalentCircuitTerminals.OutputVoltage)
    annotation (Line(points={{108,-60},{32,-60},{32,-61.1},{26,-61.1}}, color=
         {0,0,127}));
  connect(equivalentCircuitTerminals.pin_n, pin_n)
    annotation (Line(points={{-1,-80},{0,-100}}, color={0,0,255}));
  connect(equivalentCircuitTerminals.pin_p, pin_p) annotation (Line(points={{-1,
          -26.54},{-1,22},{0,22},{0,100}},    color={0,0,255}));
  connect(equivalentCircuitTerminals.ChargingCurrent, stateOfCharge.ChargingCurrent)
    annotation (Line(points={{26,-37.88},{42,-37.88},{42,-38},{58,-38},{58,
          44.8},{11.14,44.8}},
                       color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BatteryEmulatorTerminals;
