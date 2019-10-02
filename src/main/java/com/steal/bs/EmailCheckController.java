package com.steal.bs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Controller
public class EmailCheckController {

	public EmailCheckController() {
		super();
	}

	@CrossOrigin
	@RequestMapping(value = "/EmailCheck.main", method = RequestMethod.POST)
	@ResponseBody
	protected String EmailCheck(@RequestParam("email") String email) {

		String mailProtocol = "smtp";
		String mailHost = "smtp.gmail.com";
		String mailPort = "587";
		String mailId = "zongyeng@gmail.com";
		String mailPassword = "whdudCKS12";

		String fromName = "steal이메일 인증";

		String fromEmail = "zongyeng@gmail.com";

		String toEmail = email;

		String mailTitle = "steal 이메일 인증입니다.";

		String code = new TempKey().getKey(10, true);

		String mailContents = "인증번호는 : '" + code + "' 입니다. 복사 붙여넣기 해주세요.";

		String debugMode = "false";

		String authMode = "true";

		try {

			boolean debug = Boolean.valueOf(debugMode).booleanValue();

			Properties mailProps = new Properties();
			mailProps.put("mail.smtp.starttls.enable", "true");
			mailProps.setProperty("mail.transport.protocol", mailProtocol);
			mailProps.put("mail.debug", debugMode);
			mailProps.put("mail.smtp.host", mailHost);
			mailProps.put("mail.smtp.port", mailPort);
			mailProps.put("mail.smtp.connectiontimeout", "5000");
			mailProps.put("mail.smtp.timeout", "5000");
			mailProps.put("mail.smtp.auth", authMode);

			Session msgSession = null;

			if (authMode.equals("true")) {

				Authenticator auth = new MyAuthentication(mailId, mailPassword);
				msgSession = Session.getInstance(mailProps, auth);

			} else {

				msgSession = Session.getInstance(mailProps, null);

			}

			msgSession.setDebug(debug);

			MimeMessage msg = new MimeMessage(msgSession);

			msg.setFrom(new InternetAddress(fromEmail, fromName));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			msg.setSubject(mailTitle);
			msg.setContent(mailContents, "text/html; charset=UTF-8");

			Transport t = msgSession.getTransport(mailProtocol);

			try {

				t.connect();
				t.sendMessage(msg, msg.getAllRecipients());

			} finally {

				t.close();

			}

		} catch (Exception e) {

			e.printStackTrace();
			
		}

		return code;

	}
}

class MyAuthentication extends Authenticator {

	PasswordAuthentication pa;

	public MyAuthentication(String mailId, String mailPass) {

		pa = new PasswordAuthentication(mailId, mailPass);

	}

	public PasswordAuthentication getPasswordAuthentication() {

		return pa;

	}

}