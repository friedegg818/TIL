package com.sp.calc;

import org.springframework.stereotype.Service;

@Service("calc.calcService")
public class CalcServiceImpl implements CalcService {

	@Override
	public String calculator(Calc dto) {
		String s = null;
		
		switch(dto.getOperator()) {
		case "+" : s = String.format("%d+%d=%d", dto.getNum1(), dto.getNum2(), dto.getNum1()+dto.getNum2());
			break;
			
		case "-" : s = String.format("%d-%d=%d", dto.getNum1(), dto.getNum2(), dto.getNum1()-dto.getNum2());
			break;
		
		case "*" : s = String.format("%d*%d=%d", dto.getNum1(), dto.getNum2(), dto.getNum1()*dto.getNum2());
			break;
			
		case "/" : s = String.format("%d/%d=%d", dto.getNum1(), dto.getNum2(), dto.getNum1()/dto.getNum2());
			break;				
		}
		
		return s;
	}

}
