const TRANS = new Map<string, string>([
  ["G", "C"],
  ["C", "G"],
  ["T", "A"],
  ["A", "U"]
]);

export function toRna(dna: string): string {
  let res = "";

  for (let c of dna) {
    if (!TRANS.has(c)){ throw new Error('Invalid input DNA.') };
    res += TRANS.get(c)
  };
  
  return res;
}