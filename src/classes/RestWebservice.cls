@RestResource(urlMapping='/helloWorld/*')
global class RestWebservice {

  @HttpGet
  global static String helloWorld(){
    return 'HelloWorld';
  }

}