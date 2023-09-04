function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl : 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'karate01@test.com'
    config.userPassword = 'password123'
    config.userName = 'DemoTest'
  } else if (env == 'qa') {
    config.userEmail = 'karate02@test.com'
    config.userPassword = 'password123'
    config.userName = 'DemoTest01'
  }
  
  var accessToken = karate.callSingle('classpath:helpers/Login.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token '+accessToken})
  
  return config;
}