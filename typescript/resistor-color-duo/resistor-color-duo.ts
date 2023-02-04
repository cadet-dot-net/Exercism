import { inspect } from "util"
let colours: Array<string> = 
  ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white']

export function decodedValue(codes: Array<string>) {
  // throw new Error('Remove this statement and implement this function')
  // for (var code of codes) {
  //   console.log(colours.indexOf(code))
  // }
  // (10).toString()
  var code = 
    colours.indexOf(codes[0]) * 10 + 
    colours.indexOf(codes[1])
    
  return code;
}
