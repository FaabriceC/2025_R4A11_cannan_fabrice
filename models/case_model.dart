class CaseModel {
  bool hidden;
  bool hasBomb;
  bool hasExploded;
  bool hasFlag;
  int? number;

  CaseModel({
    this.hidden = true,
    this.hasBomb = false,
    this.hasExploded = false,
    this.hasFlag = false,
    this.number,
  });
}
