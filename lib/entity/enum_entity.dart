enum Status {
  spring,
  summer,
  autumn,
  winter,
}
enum Priority {
  spring,
  summer,
  autumn,
  winter,
}

class EntityUtil{
  static String statusText(int value) {
    var ret = "";
    switch(value) {
      case 1:
        ret = "新規";
        break;
      case 2:
        ret = "進行中";
        break;
      case 3:
        ret = "終了";
        break;
      default:
        break;
    }
    return ret;
  }
  static String priorityText(int value) {
    var ret = "";
    switch(value) {
      case 1:
        ret = "低め";
        break;
      case 2:
        ret = "通常";
        break;
      case 3:
        ret = "高め";
        break;
      case 4:
        ret = "緊急";
        break;
      default:
        break;
    }
    return ret;
  }
}