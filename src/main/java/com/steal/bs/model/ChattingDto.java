package com.steal.bs.model;

public class ChattingDto {
	
	private int main_seq;
	private double main_authority;
	private String main_name;
	private String main_id;
	private String main_password;
	private char main_sex;
	private String main_phonenumber;
	private String main_email;
	private int main_birth;
	private int main_emp;
	private String authority;
	
	public ChattingDto() {}

	public ChattingDto(int main_seq, double main_authority, String main_name, String main_id, String main_password,
			char main_sex, String main_phonenumber, String main_email, int main_birth, int main_emp, String authority) {
		this.main_seq = main_seq;
		this.main_authority = main_authority;
		this.main_name = main_name;
		this.main_id = main_id;
		this.main_password = main_password;
		this.main_sex = main_sex;
		this.main_phonenumber = main_phonenumber;
		this.main_email = main_email;
		this.main_birth = main_birth;
		this.main_emp = main_emp;
		this.authority = authority;
	}

	public int getMain_seq() {
		return main_seq;
	}

	public void setMain_seq(int main_seq) {
		this.main_seq = main_seq;
	}

	public double getMain_authority() {
		return main_authority;
	}

	public void setMain_authority(double main_authority) {
		this.main_authority = main_authority;
	}

	public String getMain_name() {
		return main_name;
	}

	public void setMain_name(String main_name) {
		this.main_name = main_name;
	}

	public String getMain_id() {
		return main_id;
	}

	public void setMain_id(String main_id) {
		this.main_id = main_id;
	}

	public String getMain_password() {
		return main_password;
	}

	public void setMain_password(String main_password) {
		this.main_password = main_password;
	}

	public char getMain_sex() {
		return main_sex;
	}

	public void setMain_sex(char main_sex) {
		this.main_sex = main_sex;
	}

	public String getMain_phonenumber() {
		return main_phonenumber;
	}

	public void setMain_phonenumber(String main_phonenumber) {
		this.main_phonenumber = main_phonenumber;
	}

	public String getMain_email() {
		return main_email;
	}

	public void setMain_email(String main_email) {
		this.main_email = main_email;
	}

	public int getMain_birth() {
		return main_birth;
	}

	public void setMain_birth(int main_birth) {
		this.main_birth = main_birth;
	}

	public int getMain_emp() {
		return main_emp;
	}

	public void setMain_emp(int main_emp) {
		this.main_emp = main_emp;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	@Override
	public String toString() {
		return "ChattingDto [main_seq=" + main_seq + ", main_authority=" + main_authority + ", main_name=" + main_name
				+ ", main_id=" + main_id + ", main_password=" + main_password + ", main_sex=" + main_sex
				+ ", main_phonenumber=" + main_phonenumber + ", main_email=" + main_email + ", main_birth=" + main_birth
				+ ", main_emp=" + main_emp + ", authority=" + authority + "]";
	}
	
}
