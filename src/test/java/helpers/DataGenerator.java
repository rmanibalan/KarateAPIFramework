package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {

	static Faker faker = new Faker();

	public static String getRandomEmail() {

		String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
		return email;
	}

	public static String getRandomuserName() {

		String userName = faker.name().username();
		return userName;
	}

	public static JSONObject getRandomArticle() {

		String title = faker.gameOfThrones().character();
		String description = faker.gameOfThrones().city();
		String body = faker.gameOfThrones().quote();
		JSONObject json = new JSONObject();
		json.put("title", title);
		json.put("description", description);
		json.put("body", body);
		return json;
	}

}
