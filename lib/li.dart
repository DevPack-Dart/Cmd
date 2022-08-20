
abstract class CLIEntry{
  String name;
}
abstract class CLIFlag extends CLIEntry{}
abstract class CLIOption extends CLIEntry{}
abstract class CLIArgument extends CLIEntry{}
abstract class CLIVariable extends CLIEntry{}
abstract class CLICommand extends CLIEntry with CLIWithChildren{}
abstract class CLIRoot extends CLIEntry with CLIWithChildren{
}

class CLIFlagModel extends CLIFlag with CLIModel{}
class CLIOptionModel extends CLIOption with CLIModel{}
class CLIArgumentModel extends CLIArgument with CLIModel{}
class CLIVariableModel extends CLIVariable with CLIModel{}
class CLICommandModel extends CLICommand with CLIModel{}
class CLIRootModel extends CLIEntryRoot with CLIModel{
  CLIValue parse(Iterable<String> args);
}

class CLIFlagValue extends CLIFlag with CLIValue{}
class CLIOptionValue extends CLIOption with CLIValue{}
class CLIArgumentValue extends CLIArgument with CLIValue{}
class CLIVariableValue extends CLIVariable with CLIValue{}
class CLICommandValue extends CLICommand with CLIValue{}
class CLIRootValue extends CLIEntryRoot with CLIValue{
}

mixin CLIWithChildren on CLIEntry{
  covariant List<CLICommand> commands = <CLICommand>[];
  covariant List<CLIOption> options = <CLIOption>[];
  covariant List<CLIFlag> flags = <CLIFlag>[];
  covariant List<CLIArgument> arguments = <CLIArgument>[];
  covariant List<CLIVariable> variables = <CLIVariable>[];
}
mixin CLIModel on CLIEntry{
  ///Validator of Values
  bool validate(String) => true;
}
mixin CLIValue on CLIEntry{
  String value;
}