package bank3;

public class BankVO {
	private String name; // °èÁÂÁÖ ÀÌ¸§ 
	private String account; // °èÁÂ ¹øÈ£ 
	private String password; // °èÁÂ ºñ¹Ğ¹øÈ£ 
	private int balance; // °èÁÂ ÀÜ°í 
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	
	@Override
	public String toString() {
		String s;
		
		s = name + "\t" + account + "\t" + balance;
		
		return s;
	}	
	
}
