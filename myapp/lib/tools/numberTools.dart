class NumberTools {

  static final double USDT_DECIMAL = 1000000;
  static final double RMB_DECIMAL = 100;
  static final double RMB_W_DECIMAL = 1000000;
  static final double FEE_DECIMAL = 10000;
  static String USDT_SYMBOL = '\u20AE';
  static String RMB_SYMBOL = '\u00A5';

  static double UsdtConvertDouble(int usdt,{int decimal = 2}){
    return usdt/USDT_DECIMAL;
  }

  //double转string，去掉四舍五入功能。
  static String DoubleToFixedString(double value,int decimal){
    String valueStr = value.toString();
    if(!valueStr.contains('.')){
      valueStr = valueStr + '.0';
    }

    if(decimal <= 0){
      return valueStr.substring(0,valueStr.indexOf('.'));
    }

    valueStr = '$valueStr${'0'*decimal}';

    int endIndex = valueStr.indexOf('.')+decimal+1;
    return valueStr.substring(0,endIndex);
  }

  static String FeeConvert(int fee,{int decimal = 2}){
    return DoubleToFixedString(fee/FEE_DECIMAL,decimal);
  }

  static String UsdtConvert(int usdt,{int decimal = 2,bool bare = false}){
    String usdtString = DoubleToFixedString(usdt/USDT_DECIMAL,decimal);
    return bare ? usdtString : '$USDT_SYMBOL $usdtString';
  }

  static String RmbConvert(int rmb,{int decimal = 2,bool bare = false}){
    String rmbString = DoubleToFixedString(rmb/RMB_DECIMAL,decimal);
    return bare ? rmbString : '$RMB_SYMBOL $rmbString';
  }

  static String RmbConvertW(int rmb,{int decimal = 2,bool bare = false}){
    String rmbString = DoubleToFixedString(rmb/RMB_W_DECIMAL,decimal);
    return bare ? rmbString: '$RMB_SYMBOL $rmbString';
  }

  static int UsdtConvertTransport(double usdt){
    return (usdt*USDT_DECIMAL).toInt();
  }

  static int RmbConvertTransport(double rmb){
    return (rmb*RMB_DECIMAL).toInt();
  }

  static int GetBitValue(List<bool> mType){
    int typeValue = 0;
    int base = 1;
    for(int i=0;i<mType.length;i++){
      if(mType[i]){
        typeValue = typeValue | base;
      }
      base *= 2;
    }
    return typeValue;
  }

  static List<bool> ConvertBitList(int value){
    List<bool> result = [false,false,false,false,false,false,false,false];
    if(value != null){
      int base = 1;
      for(int i=0;i<8;i++){
        result[i] = (value & base) == base ? true : false;
        base *= 2;
      }
    }
    return result;
  }

}