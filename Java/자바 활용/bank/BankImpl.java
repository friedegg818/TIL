package bank3;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class BankImpl implements Bank {
	private List<BankVO> list = new ArrayList<>();
	Scanner sc = new Scanner(System.in);

	// °èÁÂ »ı¼º (ÀÌ¸§, °èÁÂ¹øÈ£, ºñ¹Ğ¹øÈ£ ÀÔ·Â ¹Ş¾Æ »ı¼º)
	// µ¿ÀÏÇÑ °èÁÂ°¡ ÀÖÀ¸¸é »ı¼º ºÒ°¡
	@Override
	public void create() {

		System.out.println("»õ·Î¿î °èÁÂ¸¦ »ı¼ºÇÕ´Ï´Ù.");

		try {
			BankVO vo = new BankVO();

			// ÀÌ¸§
			System.out.println("ÀÌ¸§À» ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
			vo.setName(sc.next());

			// °èÁÂ¹øÈ£
			System.out.println("»ç¿ë ÇÒ °èÁÂ¹øÈ£¸¦ ÀÔ·Â ÇØ ÁÖ¼¼¿ä. (´Ü, °èÁÂ¹øÈ£´Â 7-10 ÀÚ¸® »çÀÌÀÇ ¼ıÀÚ¿©¾ß ÇÔ)");
			String account = sc.next();

			// Á¶°Ç1 - °èÁÂ¹øÈ£°¡ ¸ğµÎ ¼ıÀÚ·Î ÀÌ·ç¾îÁ® ÀÖ´ÂÁö È®ÀÎ
			for (int i = 0; i < account.length(); i++) {
				char tmp = account.charAt(i); // ¹®ÀÚ¿­À» ÇÏ³ª¾¿ ºñ±³
				if (Character.isDigit(tmp) == false) { // ¼ıÀÚ°¡ ¾Æ´Ñ °ÍÀÌ ÀÖ´Ù¸é
					System.out.println("°èÁÂ¹øÈ£´Â ¼ıÀÚ¸¸ °¡´ÉÇÕ´Ï´Ù.");
					return;
				}
			}

			// Á¶°Ç2 - °èÁÂ¹øÈ£°¡ 7~10ÀÚ¸® »çÀÌÀÎÁö È®ÀÎ
			if (account.length() < 7 || account.length() > 10) {
				System.out.println("°èÁÂ ¹øÈ£´Â 7~10ÀÚ¸®ÀÇ ¼ıÀÚ¸¸ °¡´ÉÇÕ´Ï´Ù.");
			}

			vo.setAccount(account);

			// µ¿ÀÏÇÑ °èÁÂ°¡ ÀÖ´ÂÁö È®ÀÎ
			if (readAcc(vo.getAccount()) != null) {
				System.out.println("µ¿ÀÏÇÑ °èÁÂ°¡ Á¸ÀçÇÕ´Ï´Ù.");
			}

			// ºñ¹Ğ¹øÈ£
			System.out.println("»ç¿ë ÇÒ ºñ¹Ğ¹øÈ£¸¦ ÀÔ·Â ÇØ ÁÖ¼¼¿ä. (ºñ¹Ğ¹øÈ£´Â ¹İµå½Ã 1°³ ÀÌ»óÀÇ Æ¯¼ö¹®ÀÚ¸¦ Æ÷ÇÔÇØ¾ß ÇÕ´Ï´Ù.)");
			String password = sc.next();

			// Æ¯¼ö¹®ÀÚ¸¦ °¡Áö°í ÀÖ´ÂÁö È®ÀÎ
			if (password.matches("[0-9|a-z|A-Z|¤¡-¤¾|¤¿-¤Ó|°¡-ÆR]*") == false) {
				System.out.println("ºñ¹Ğ¹øÈ£°¡ ¼³Á¤µÇ¾ú½À´Ï´Ù.");
				vo.setPassword(password);
			} else {
				System.out.println("ºñ¹Ğ¹øÈ£´Â 1°³ ÀÌ»óÀÇ Æ¯¼ö¹®ÀÚ¸¦ Æ÷ÇÔÇØ¾ß ÇÕ´Ï´Ù.");
				return;
			}

			// ÃÊ±â ÀÔ±İ
			System.out.println("ÀÔ±İÀ» ¹Ù·Î ÇÏ½Ã°Ú½À´Ï±î?[Y/N]");
			String ch = sc.next();

			switch (ch) {
			case "Y":
			case "y":
				System.out.println("ÀÔ±İ ÇÒ ±İ¾×À» ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
				vo.setBalance(sc.nextInt());
				break;

			case "N":
			case "n":
				System.out.println("ÀÔ±İÀ» ÁøÇàÇÏÁö ¾Ê½À´Ï´Ù.");
				break;
			}

			// °èÁÂ »ı¼º ¿Ï·á
			System.out.println("°èÁÂ »ı¼ºÀÌ ¿Ï·á µÇ¾ú½À´Ï´Ù.");
			
			list.add(vo);
			
			System.out.println(vo.getName() + "´ÔÀÇ ÇöÀç ÀÜ°í : " + vo.getBalance());

		} catch (InputMismatchException e) {
			System.out.println("±İ¾×Àº ¼ıÀÚ¸¸ ÀÔ·Â ÇØ ÁÖ¼¼¿ä,");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// ÀÔ±İ
	@Override
	public void deposit() {

		String account;
		String password;
		int moneyIn; // ÀÔ±İ ±İ¾×

		System.out.println("ÀÔ±İ ÇÏ½Ç °èÁÂ ¹øÈ£¸¦ ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
		account = sc.next();

		BankVO vo = readAcc(account);

		// ¾ø´Â °èÁÂ ÀÏ °æ¿ì
		if (vo == null) {
			System.out.println("Á¸Àç ÇÏÁö ¾Ê´Â °èÁÂ Á¤º¸ ÀÔ´Ï´Ù. ¹øÈ£¸¦ È®ÀÎ ÇØ ÁÖ¼¼¿ä.");
			return;
		}

		// ºñ¹Ğ¹øÈ£ ÀÔ·Â
		System.out.println("ºñ¹Ğ¹øÈ£¸¦ ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
		password = sc.next();

		if (!password.equals(vo.getPassword())) {
			System.out.println("ºñ¹Ğ¹øÈ£°¡ ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù. ´Ù½Ã ÇÑ ¹ø È®ÀÎÇØ ÁÖ¼¼¿ä.");
			return;
		}

		// ÀÔ±İ ½ÃÀÛ
		System.out.println("ÀÔ±İ ÇÒ ±İ¾×À» ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
		moneyIn = sc.nextInt();

		// ÀÔ±İ¾×Àº 0¿ø ÀÌ»óÀÌ¾î¾ß ÇÔ
		if (moneyIn < 0) {
			System.out.println("ÃÖ¼Ò 0¿ø ÀÌ»óÀ» ÀÔ±İ ÇÏ¼Å¾ß ÇÕ´Ï´Ù.");
			return;
		}

		System.out.println("ÀÔ±İÀÌ ¿Ï·á µÇ¾ú½À´Ï´Ù.");

		vo.setBalance(vo.getBalance() + moneyIn);

		System.out.println(vo.getName() + "´ÔÀÇ ÇöÀç ÀÜ°í : " + vo.getBalance());
	}

	// Ãâ±İ
	@Override
	public void withdraw() {

		String account;
		String password;
		int moneyOut; // Ãâ±İ ±İ¾×

		System.out.println("Ãâ±İ ÇÏ½Ç °èÁÂ ¹øÈ£¸¦ ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
		account = sc.next();

		BankVO vo = readAcc(account);

		// ¾ø´Â °èÁÂ ÀÏ °æ¿ì
		if (vo == null) {
			System.out.println("Á¸Àç ÇÏÁö ¾Ê´Â °èÁÂ Á¤º¸ ÀÔ´Ï´Ù. ¹øÈ£¸¦ È®ÀÎ ÇØ ÁÖ¼¼¿ä.");
			return;
		}

		// ºñ¹Ğ¹øÈ£ ÀÔ·Â
		System.out.println("ºñ¹Ğ¹øÈ£¸¦ ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
		password = sc.next();

		if (!password.equals(vo.getPassword())) {
			System.out.println("ºñ¹Ğ¹øÈ£°¡ ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù. ´Ù½Ã ÇÑ ¹ø È®ÀÎÇØ ÁÖ¼¼¿ä.");
			return;
		}

		// Ãâ±İ ½ÃÀÛ
		System.out.println("Ãâ±İ ÇÒ ±İ¾×À» ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
		moneyOut = sc.nextInt();

		// ÀÜ°íº¸´Ù ¸¹ÀÌ Ãâ±İ ÇÒ °æ¿ì¿¡´Â ºÒ°¡
		if (moneyOut > vo.getBalance()) {
			System.out.println("ÀÜ°í°¡ ºÎÁ·ÇÏ¿© Ãâ±İ ÇÒ ¼ö ¾ø½À´Ï´Ù.");
			return;
		}

		System.out.println("Ãâ±İÀÌ ¿Ï·á µÇ¾ú½À´Ï´Ù.");

		vo.setBalance(vo.getBalance() - moneyOut);

		System.out.println(vo.getName() + "´ÔÀÇ ÇöÀç ÀÜ°í : " + vo.getBalance());
	}

	// °èÁÂ »èÁ¦
	@Override
	public void delete() {

		String account;
		String password;

		System.out.println("»èÁ¦ ÇÒ °èÁÂ¹øÈ£¸¦ ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
		account = sc.next();

		BankVO vo = readAcc(account);

		if (vo == null) {
			System.out.println("°èÁÂ Á¤º¸°¡ Á¸ÀçÇÏÁö ¾Ê½À´Ï´Ù. °èÁÂ ¹øÈ£¸¦ È®ÀÎ ÇØ ÁÖ¼¼¿ä.");
			return;
		}

		System.out.println("ºñ¹Ğ¹øÈ£¸¦ ÀÔ·Â ÇØ ÁÖ¼¼¿ä.");
		password = sc.next();

		if (password.equals(vo.getPassword())) {
			System.out.println("°èÁÂ¸¦ Á¤¸» »èÁ¦ÇÏ½Ã°Ú½À´Ï±î? »èÁ¦ ÇÑ °èÁÂ´Â º¹±¸ ºÒ°¡ÇÕ´Ï´Ù.[Y/N]");
			String ch = sc.next();

			if (ch.equals("Y") || ch.equals("y")) {
				System.out.println("°èÁÂ¸¦ ¿µ±¸ »èÁ¦ÇÕ´Ï´Ù.");
				list.remove(vo);
			} else {
				System.out.println("°èÁÂ »èÁ¦¸¦ Ãë¼Ò ÇÕ´Ï´Ù.");
				return;
			}

		} else {
			System.out.println("ºñ¹Ğ¹øÈ£°¡ ÀÏÄ¡ÇÏÁö ¾ÊÀ¸´Ï ´Ù½Ã ÇÑ ¹ø È®ÀÎ ÇØ ÁÖ¼¼¿ä.");
		}
	}

	// °èÁÂ ¸ñ·Ï Ãâ·Â
	@Override
	public void check() {
		System.out.println("[°èÁÂ ¸ñ·Ï È®ÀÎ]");
		System.out.println("ÀÌ¸§\t°èÁÂ¹øÈ£\tÀÜ¾×");

		for (BankVO vo : list) {
			System.out.println(vo);

			if (list == null) {
				System.out.println("°èÁÂ Á¤º¸°¡ ¾ø½À´Ï´Ù.");
			}
		}

	}

	// ±âÁ¸ °èÁÂ Á¤º¸¿¡¼­, °èÁÂ ¹øÈ£¸¦ ÀÌ¿ëÇÏ¿© Æ¯Á¤ °èÁÂ¸¦ ºÒ·¯¿À´Â ¸Ş¼Òµå
	private BankVO readAcc(String account) {
		for (BankVO vo : list) {
			if (vo.getAccount().equals(account)) {
				return vo;
			}
		}
		return null;
	}

}
