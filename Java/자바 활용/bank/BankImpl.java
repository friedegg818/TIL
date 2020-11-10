package bank3;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class BankImpl implements Bank {
	private List<BankVO> list = new ArrayList<>();
	Scanner sc = new Scanner(System.in);

	// ���� ���� (�̸�, ���¹�ȣ, ��й�ȣ �Է� �޾� ����)
	// ������ ���°� ������ ���� �Ұ�
	@Override
	public void create() {

		System.out.println("���ο� ���¸� �����մϴ�.");

		try {
			BankVO vo = new BankVO();

			// �̸�
			System.out.println("�̸��� �Է� �� �ּ���.");
			vo.setName(sc.next());

			// ���¹�ȣ
			System.out.println("��� �� ���¹�ȣ�� �Է� �� �ּ���. (��, ���¹�ȣ�� 7-10 �ڸ� ������ ���ڿ��� ��)");
			String account = sc.next();

			// ����1 - ���¹�ȣ�� ��� ���ڷ� �̷���� �ִ��� Ȯ��
			for (int i = 0; i < account.length(); i++) {
				char tmp = account.charAt(i); // ���ڿ��� �ϳ��� ��
				if (Character.isDigit(tmp) == false) { // ���ڰ� �ƴ� ���� �ִٸ�
					System.out.println("���¹�ȣ�� ���ڸ� �����մϴ�.");
					return;
				}
			}

			// ����2 - ���¹�ȣ�� 7~10�ڸ� �������� Ȯ��
			if (account.length() < 7 || account.length() > 10) {
				System.out.println("���� ��ȣ�� 7~10�ڸ��� ���ڸ� �����մϴ�.");
			}

			vo.setAccount(account);

			// ������ ���°� �ִ��� Ȯ��
			if (readAcc(vo.getAccount()) != null) {
				System.out.println("������ ���°� �����մϴ�.");
			}

			// ��й�ȣ
			System.out.println("��� �� ��й�ȣ�� �Է� �� �ּ���. (��й�ȣ�� �ݵ�� 1�� �̻��� Ư�����ڸ� �����ؾ� �մϴ�.)");
			String password = sc.next();

			// Ư�����ڸ� ������ �ִ��� Ȯ��
			if (password.matches("[0-9|a-z|A-Z|��-��|��-��|��-�R]*") == false) {
				System.out.println("��й�ȣ�� �����Ǿ����ϴ�.");
				vo.setPassword(password);
			} else {
				System.out.println("��й�ȣ�� 1�� �̻��� Ư�����ڸ� �����ؾ� �մϴ�.");
				return;
			}

			// �ʱ� �Ա�
			System.out.println("�Ա��� �ٷ� �Ͻðڽ��ϱ�?[Y/N]");
			String ch = sc.next();

			switch (ch) {
			case "Y":
			case "y":
				System.out.println("�Ա� �� �ݾ��� �Է� �� �ּ���.");
				vo.setBalance(sc.nextInt());
				break;

			case "N":
			case "n":
				System.out.println("�Ա��� �������� �ʽ��ϴ�.");
				break;
			}

			// ���� ���� �Ϸ�
			System.out.println("���� ������ �Ϸ� �Ǿ����ϴ�.");
			
			list.add(vo);
			
			System.out.println(vo.getName() + "���� ���� �ܰ� : " + vo.getBalance());

		} catch (InputMismatchException e) {
			System.out.println("�ݾ��� ���ڸ� �Է� �� �ּ���,");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// �Ա�
	@Override
	public void deposit() {

		String account;
		String password;
		int moneyIn; // �Ա� �ݾ�

		System.out.println("�Ա� �Ͻ� ���� ��ȣ�� �Է� �� �ּ���.");
		account = sc.next();

		BankVO vo = readAcc(account);

		// ���� ���� �� ���
		if (vo == null) {
			System.out.println("���� ���� �ʴ� ���� ���� �Դϴ�. ��ȣ�� Ȯ�� �� �ּ���.");
			return;
		}

		// ��й�ȣ �Է�
		System.out.println("��й�ȣ�� �Է� �� �ּ���.");
		password = sc.next();

		if (!password.equals(vo.getPassword())) {
			System.out.println("��й�ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �� �� Ȯ���� �ּ���.");
			return;
		}

		// �Ա� ����
		System.out.println("�Ա� �� �ݾ��� �Է� �� �ּ���.");
		moneyIn = sc.nextInt();

		// �Աݾ��� 0�� �̻��̾�� ��
		if (moneyIn < 0) {
			System.out.println("�ּ� 0�� �̻��� �Ա� �ϼž� �մϴ�.");
			return;
		}

		System.out.println("�Ա��� �Ϸ� �Ǿ����ϴ�.");

		vo.setBalance(vo.getBalance() + moneyIn);

		System.out.println(vo.getName() + "���� ���� �ܰ� : " + vo.getBalance());
	}

	// ���
	@Override
	public void withdraw() {

		String account;
		String password;
		int moneyOut; // ��� �ݾ�

		System.out.println("��� �Ͻ� ���� ��ȣ�� �Է� �� �ּ���.");
		account = sc.next();

		BankVO vo = readAcc(account);

		// ���� ���� �� ���
		if (vo == null) {
			System.out.println("���� ���� �ʴ� ���� ���� �Դϴ�. ��ȣ�� Ȯ�� �� �ּ���.");
			return;
		}

		// ��й�ȣ �Է�
		System.out.println("��й�ȣ�� �Է� �� �ּ���.");
		password = sc.next();

		if (!password.equals(vo.getPassword())) {
			System.out.println("��й�ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �� �� Ȯ���� �ּ���.");
			return;
		}

		// ��� ����
		System.out.println("��� �� �ݾ��� �Է� �� �ּ���.");
		moneyOut = sc.nextInt();

		// �ܰ��� ���� ��� �� ��쿡�� �Ұ�
		if (moneyOut > vo.getBalance()) {
			System.out.println("�ܰ� �����Ͽ� ��� �� �� �����ϴ�.");
			return;
		}

		System.out.println("����� �Ϸ� �Ǿ����ϴ�.");

		vo.setBalance(vo.getBalance() - moneyOut);

		System.out.println(vo.getName() + "���� ���� �ܰ� : " + vo.getBalance());
	}

	// ���� ����
	@Override
	public void delete() {

		String account;
		String password;

		System.out.println("���� �� ���¹�ȣ�� �Է� �� �ּ���.");
		account = sc.next();

		BankVO vo = readAcc(account);

		if (vo == null) {
			System.out.println("���� ������ �������� �ʽ��ϴ�. ���� ��ȣ�� Ȯ�� �� �ּ���.");
			return;
		}

		System.out.println("��й�ȣ�� �Է� �� �ּ���.");
		password = sc.next();

		if (password.equals(vo.getPassword())) {
			System.out.println("���¸� ���� �����Ͻðڽ��ϱ�? ���� �� ���´� ���� �Ұ��մϴ�.[Y/N]");
			String ch = sc.next();

			if (ch.equals("Y") || ch.equals("y")) {
				System.out.println("���¸� ���� �����մϴ�.");
				list.remove(vo);
			} else {
				System.out.println("���� ������ ��� �մϴ�.");
				return;
			}

		} else {
			System.out.println("��й�ȣ�� ��ġ���� ������ �ٽ� �� �� Ȯ�� �� �ּ���.");
		}
	}

	// ���� ��� ���
	@Override
	public void check() {
		System.out.println("[���� ��� Ȯ��]");
		System.out.println("�̸�\t���¹�ȣ\t�ܾ�");

		for (BankVO vo : list) {
			System.out.println(vo);

			if (list == null) {
				System.out.println("���� ������ �����ϴ�.");
			}
		}

	}

	// ���� ���� ��������, ���� ��ȣ�� �̿��Ͽ� Ư�� ���¸� �ҷ����� �޼ҵ�
	private BankVO readAcc(String account) {
		for (BankVO vo : list) {
			if (vo.getAccount().equals(account)) {
				return vo;
			}
		}
		return null;
	}

}
