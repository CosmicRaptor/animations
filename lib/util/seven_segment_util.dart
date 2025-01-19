List<bool> getSegments(String input) {
  if (input.length != 1) {
    throw ArgumentError("You must pass a single character");
  }

  const Map<String, List<bool>> characterMap = {
    '0': [true, true, true, true, true, true, false],
    '1': [false, true, true, false, false, false, false],
    '2': [true, true, false, true, true, false, true],
    '3': [true, true, true, true, false, false, true],
    '4': [false, true, true, false, false, true, true],
    '5': [true, false, true, true, false, true, true],
    '6': [true, false, true, true, true, true, true],
    '7': [true, true, true, false, false, false, false],
    '8': [true, true, true, true, true, true, true],
    '9': [true, true, true, true, false, true, true],
  };

  if (characterMap.keys.contains(input)) {
    return characterMap[input]!;
  } else {
    throw UnimplementedError("This character is not supported");
  }
}
