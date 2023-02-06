export function isLeap(year: number): boolean {
  let res:boolean = false;
  
  if (year % 4 == 0) {
    res = true;

    if (year % 100 == 0 && year % 400 != 0) {
      res = false;
    };
  };
  
  return res;
}
