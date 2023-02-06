const colours = [
  'black',
  'brown',
  'red',
  'orange',
  'yellow',
  'green',
  'blue',
  'violet',
  'grey',
  'white'
]

export function decodedResistorValue(bands: Array<string>): string {
  var code = colours.indexOf(bands[0]) * 10 +  colours.indexOf(bands[1])
  var exponent = colours.indexOf(bands[2])
  if (exponent >= 2) {
    return code * (10 ** (exponent - 3)) +" kiloohms"
  } else {
    return code * (10 ** exponent)+" ohms"
  }
}
