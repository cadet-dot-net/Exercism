let colours: Array<string> = [
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
];

export function decodedValue(bands: Array<string>) {
  var code =   colours.indexOf(bands[0]) * 10 +  colours.indexOf(bands[1])
  return code;
}
