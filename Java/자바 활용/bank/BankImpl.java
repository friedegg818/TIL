package bank3;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class BankImpl implements Bank {
	private List<BankVO> list = new ArrayList<>();
	Scanner sc = new Scanner(System.in);

	// 계좌 생성 (이름, 계좌번호, 비밀번호 입력 받아 생성)
	// 동일한 계좌가 있으면 생성 불가
	@Override
	public void create() {

		System.out.println("새로운 계좌를 생성합니다.");

		try {
			BankVO vo = new BankVO();

			// 이름
			System.out.println("이름을 입력 해 주세요.");
			vo.setName(sc.next());

			// 계좌번호
			System.out.println("사용 할 계좌번호를 입력 해 주세요. (단, 계좌번호는 7-10 자리 사이의 숫자여야 함)");
			String account = sc.next();

			// 조건1 - 계좌번호가 모두 숫자로 이루어져 있는지 확인
			for (int i = 0; i < account.length(); i++) {
				char tmp = account.charAt(i); // 문자열을 하나씩 비교
				if (Character.isDigit(tmp) == false) { // 숫자가 아닌 것이 있다면
					System.out.println("계좌번호는 숫자만 가능합니다.");
					return;
				}
			}

			// 조건2 - 계좌번호가 7~10자리 사이인지 확인
			if (account.length() < 7 || account.length() > 10) {
				System.out.println("계좌 번호는 7~10자리의 숫자만 가능합니다.");
			}

			vo.setAccount(account);

			// 동일한 계좌가 있는지 확인
			if (readAcc(vo.getAccount()) != null) {
				System.out.println("동일한 계좌가 존재합니다.");
			}

			// 비밀번호
			System.out.println("사용 할 비밀번호를 입력 해 주세요. (비밀번호는 반드시 1개 이상의 특수문자를 포함해야 합니다.)");
			String password = sc.next();

			// 특수문자를 가지고 있는지 확인
			if (password.matches("[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*") == false) {
				System.out.println("비밀번호가 설정되었습니다.");
				vo.setPassword(password);
			} else {
				System.out.println("비밀번호는 1개 이상의 특수문자를 포함해야 합니다.");
				return;
			}

			// 초기 입금
			System.out.println("입금을 바로 하시겠습니까?[Y/N]");
			String ch = sc.next();

			switch (ch) {
			case "Y":
			case "y":
				System.out.println("입금 할 금액을 입력 해 주세요.");
				vo.setBalance(sc.nextInt());
				break;

			case "N":
			case "n":
				System.out.println("입금을 진행하지 않습니다.");
				break;
			}

			// 계좌 생성 완료
			System.out.println("계좌 생성이 완료 되었습니다.");
			
			list.add(vo);
			
			System.out.println(vo.getName() + "님의 현재 잔고 : " + vo.getBalance());

		} catch (InputMismatchException e) {
			System.out.println("금액은 숫자만 입력 해 주세요,");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 입금
	@Override
	public void deposit() {

		String account;
		String password;
		int moneyIn; // 입금 금액

		System.out.println("입금 하실 계좌 번호를 입력 해 주세요.");
		account = sc.next();

		BankVO vo = readAcc(account);

		// 없는 계좌 일 경우
		if (vo == null) {
			System.out.println("존재 하지 않는 계좌 정보 입니다. 번호를 확인 해 주세요.");
			return;
		}

		// 비밀번호 입력
		System.out.println("비밀번호를 입력 해 주세요.");
		password = sc.next();

		if (!password.equals(vo.getPassword())) {
			System.out.println("비밀번호가 일치하지 않습니다. 다시 한 번 확인해 주세요.");
			return;
		}

		// 입금 시작
		System.out.println("입금 할 금액을 입력 해 주세요.");
		moneyIn = sc.nextInt();

		// 입금액은 0원 이상이어야 함
		if (moneyIn < 0) {
			System.out.println("최소 0원 이상을 입금 하셔야 합니다.");
			return;
		}

		System.out.println("입금이 완료 되었습니다.");

		vo.setBalance(vo.getBalance() + moneyIn);

		System.out.println(vo.getName() + "님의 현재 잔고 : " + vo.getBalance());
	}

	// 출금
	@Override
	public void withdraw() {

		String account;
		String password;
		int moneyOut; // 출금 금액

		System.out.println("출금 하실 계좌 번호를 입력 해 주세요.");
		account = sc.next();

		BankVO vo = readAcc(account);

		// 없는 계좌 일 경우
		if (vo == null) {
			System.out.println("존재 하지 않는 계좌 정보 입니다. 번호를 확인 해 주세요.");
			return;
		}

		// 비밀번호 입력
		System.out.println("비밀번호를 입력 해 주세요.");
		password = sc.next();

		if (!password.equals(vo.getPassword())) {
			System.out.println("비밀번호가 일치하지 않습니다. 다시 한 번 확인해 주세요.");
			return;
		}

		// 출금 시작
		System.out.println("출금 할 금액을 입력 해 주세요.");
		moneyOut = sc.nextInt();

		// 잔고보다 많이 출금 할 경우에는 불가
		if (moneyOut > vo.getBalance()) {
			System.out.println("잔고가 부족하여 출금 할 수 없습니다.");
			return;
		}

		System.out.println("출금이 완료 되었습니다.");

		vo.setBalance(vo.getBalance() - moneyOut);

		System.out.println(vo.getName() + "님의 현재 잔고 : " + vo.getBalance());
	}

	// 계좌 삭제
	@Override
	public void delete() {

		String account;
		String password;

		System.out.println("삭제 할 계좌번호를 입력 해 주세요.");
		account = sc.next();

		BankVO vo = readAcc(account);

		if (vo == null) {
			System.out.println("계좌 정보가 존재하지 않습니다. 계좌 번호를 확인 해 주세요.");
			return;
		}

		System.out.println("비밀번호를 입력 해 주세요.");
		password = sc.next();

		if (password.equals(vo.getPassword())) {
			System.out.println("계좌를 정말 삭제하시겠습니까? 삭제 한 계좌는 복구 불가합니다.[Y/N]");
			String ch = sc.next();

			if (ch.equals("Y") || ch.equals("y")) {
				System.out.println("계좌를 영구 삭제합니다.");
				list.remove(vo);
			} else {
				System.out.println("계좌 삭제를 취소 합니다.");
				return;
			}

		} else {
			System.out.println("비밀번호가 일치하지 않으니 다시 한 번 확인 해 주세요.");
		}
	}

	// 계좌 목록 출력
	@Override
	public void check() {
		System.out.println("[계좌 목록 확인]");
		System.out.println("이름\t계좌번호\t잔액");

		for (BankVO vo : list) {
			System.out.println(vo);

			if (list == null) {
				System.out.println("계좌 정보가 없습니다.");
			}
		}

	}

	// 기존 계좌 정보에서, 계좌 번호를 이용하여 특정 계좌를 불러오는 메소드
	private BankVO readAcc(String account) {
		for (BankVO vo : list) {
			if (vo.getAccount().equals(account)) {
				return vo;
			}
		}
		return null;
	}

}
