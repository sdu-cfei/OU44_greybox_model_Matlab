within BatteryEmulator;
model ThermalExchange
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor batThermalMass(C=C)
    annotation (Placement(transformation(extent={{-12,18},{66,96}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{16,-16},{-16,16}},
        rotation=180,
        origin={-16,-80})));
  Modelica.Blocks.Interfaces.RealInput P_in annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-104,-80})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{56,-14},{84,14}})));
  Modelica.Blocks.Interfaces.RealOutput BatteryTemperature
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-20,-20})));
  Modelica.Blocks.Sources.RealExpression ConvCoeff(y=h_conv)
    annotation (Placement(transformation(extent={{-96,20},{-64,42}})));
  Modelica.Blocks.Math.Gain ConvArea(k=cell_area) annotation (Placement(
        transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-39,31})));

  Modelica.Blocks.Interfaces.RealInput AmbientTemperature annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-104,-20})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-74,-32},{-50,-8}})));
  parameter Real cell_area=0.101908 "Convection Area";
  parameter Real h_conv=5 "Convection coefficient";
  parameter Modelica.Units.SI.Mass cell_mass=1;
  parameter Modelica.Units.SI.SpecificHeatCapacity cell_Cp_heat=810.5328;
  parameter Modelica.Units.SI.HeatCapacity C=cell_mass*cell_Cp_heat
    "Heat capacity of element (= cp*m)";
equation
  connect(ConvCoeff.y, ConvArea.u)
    annotation (Line(points={{-62.4,31},{-49.8,31}}, color={0,0,127}));
  connect(prescribedHeatFlow.Q_flow, P_in)
    annotation (Line(points={{-32,-80},{-104,-80}}, color={0,0,127}));
  connect(AmbientTemperature, prescribedTemperature.T)
    annotation (Line(points={{-104,-20},{-76.4,-20}}, color={0,0,127}));
  connect(prescribedTemperature.port, convection.fluid)
    annotation (Line(points={{-50,-20},{-40,-20}}, color={191,0,0}));
  connect(prescribedHeatFlow.port, batThermalMass.port)
    annotation (Line(points={{0,-80},{27,-80},{27,18}}, color={191,0,0}));
  connect(convection.solid, batThermalMass.port)
    annotation (Line(points={{0,-20},{27,-20},{27,18}}, color={191,0,0}));
  connect(ConvArea.y, convection.Gc)
    annotation (Line(points={{-29.1,31},{-20,31},{-20,0}}, color={0,0,127}));
  connect(temperatureSensor.T, BatteryTemperature)
    annotation (Line(points={{85.4,0},{106,0}},
                                              color={0,0,127}));
  connect(temperatureSensor.port, batThermalMass.port)
    annotation (Line(points={{56,0},{27,0},{27,18}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermalExchange;
