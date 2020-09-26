//one of the most difficult codes to form till now , with the help of some references...

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].

/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the color and units to not be null.
  const ConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

//SO this is basically the stateful widget as an extension to the Stateless Widget
//As we know a class has mainly two things , it's state and behaviour
//so this class below changes the state of the [ ConverterRoute ] tab



class _ConverterRouteState extends State<ConverterRoute> {
  // TODO: Set some variables, such as for keeping track of the user's input
  // value and units

  //for conversion purposes
  Unit _fromUnit , _toUnit;
  //converted values
  double _inputValue;
  String _outputValue = '';
  //if wrong input
  bool _showValidationError = false;

  //list of all the units
  List<DropdownMenuItem> _unitMenuItems;



  // TODO: Determine whether you need to override anything, such as initState()
  //Yeah so we needed a init state for changing the values in the dropdown list
  @override
  void initState(){
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }
  // TODO: Add other helper functions. We've given you one, _format()

  //make DropdownMenuItem
  void _createDropdownMenuItems(){
    List<DropdownMenuItem> _unitItemsList = <DropdownMenuItem>[];
    for(Unit unit in widget.units){
      _unitItemsList.add(
        DropdownMenuItem(
          value: unit.name,
          child: Container(
            child: Text(
              unit.name,
              softWrap: true,
            ),
          ),
        )
      );
    }
    setState(() {
      _unitMenuItems = _unitItemsList;
    });
  }

  //setting the defaults in the init state
  void _setDefaults(){
    setState(() {
      _fromUnit = widget.units[0];
      _toUnit = widget.units[1];
    });
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  //updating the conversion every time we change the dropdown selection
  void _updateConversion(){
    setState(() {
      _outputValue = _format(_inputValue * (_toUnit.conversion / _fromUnit.conversion));
    });
  }

  void _updateInputValue(String input){
    setState(() {
      if(input == null || input.isEmpty){
        _outputValue = '';
      }else{
        try{
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch(e){
          print('Error : $e');
          _showValidationError = true;
        }
      }
    });
  }

  //to get the unit with a particular name
  Unit _getUnit(String unitName){
    return widget.units.firstWhere((Unit unit){
      return unit.name == unitName;
    }, orElse: null,
    );
  }


  //for different conversion from different units

  void _updateFromConversion(dynamic unitName){
    setState(() {
      _fromUnit = _getUnit(unitName);
    });
    if(_inputValue != null){
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName){
    setState(() {
      _toUnit = _getUnit(unitName);
    });
    if(_inputValue != null){
      _updateConversion();
    }
  }

  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        // This sets the color of the [DropdownButton] itself
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        // This sets the color of the [DropdownMenuItem]
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: Create the 'input' group of widgets. This is a Column that
    // includes the input value, and 'from' unit [Dropdown].
    final input = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,

            child :TextField(

              keyboardType : TextInputType.number,
              style: Theme.of(context).textTheme.headline2,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.headline2,
                labelText: 'Input',
                errorText: _showValidationError ? 'Invalid Number entered': null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                )
              ),
              onChanged: _updateInputValue,
            ),

          ),
          _createDropdown(_fromUnit.name , _updateFromConversion),
        ],
      ),
    );

    // TODO: Create a compare arrows icon.
    final arrow = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );


    // TODO: Create the 'output' group of widgets. This is a Column that
    // includes the output value, and 'to' unit [Dropdown].
    final output = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            child: Text(
              _outputValue,
              style: Theme.of(context).textTheme.headline2,
            ),
            decoration: InputDecoration(
              labelText: 'Output',
              labelStyle: Theme.of(context).textTheme.headline2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              )
            ),
          ),
          _createDropdown(_toUnit.name , _updateToConversion),
        ],
      ),
    );

    final converter = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        input,
        arrow,
        output,
      ],
    );


    // TODO: Return the input, arrows, and output widgets, wrapped in a Column.
    return converter;
  }
}
