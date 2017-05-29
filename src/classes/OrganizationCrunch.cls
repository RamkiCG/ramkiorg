public class OrganizationCrunch {

    public class Sub_organizations 
    {
        public Paging paging{get;set;}
        public List<Items_Y> items{get;set;}
    }

    public class News 
    {
        public Paging paging{get;set;}
        public List<Items_Q> items{get;set;}
    }

    public class Categories 
    {
        public Paging paging{get;set;}
        public List<Items_U> items{get;set;}
    }

    public class Funding_round
    {
        public String path{get;set;}
    }

    public class Properties 
    {
        public Boolean role_company{get;set;}
        public String email_address{get;set;}
        public String description{get;set;}
        public String short_description{get;set;}
        public Integer founded_on_day{get;set;}
        public Integer founded_on_month{get;set;}
        public Integer founded_on_year{get;set;}
        public String founded_on{get;set;}
        public Integer founded_on_trust_code{get;set;}
        public String permalink{get;set;}
        public String primary_role{get;set;}
        public Boolean is_closed{get;set;}
        public Integer closed_on_trust_code{get;set;}
        public String homepage_url{get;set;}
        public String name{get;set;}
        public Object closed_on_day{get;set;}
        public Object closed_on_month{get;set;}
        public Object closed_on_year{get;set;}
        public Object closed_on{get;set;}
        public Boolean role_investor{get;set;}
        public Boolean secondary_role_for_profit{get;set;}
        public Integer num_employees_min{get;set;}
        public Integer num_employees_max{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
        public Integer total_funding_usd{get;set;}
        public Integer number_of_investments{get;set;}
        public String stock_symbol{get;set;}
        public Integer number_of_employees{get;set;}
    }

    public class Data 
    {
        public String uuid{get;set;}
        public String type{get;set;}
        public Properties properties{get;set;}
        public Relationships relationships{get;set;}
    }

    public class Items_Q 
    {
        public String url{get;set;}
        public Object author{get;set;}
        public String posted_on{get;set;}
        public String type{get;set;}
        public String title{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
    }

    public class Items_R 
    {
        public String url{get;set;}
        public String type{get;set;}
        public String title{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
    }

    public class Paging 
    {
        public Integer total_items{get;set;}
        public String first_page_url{get;set;}
        public String sort_order{get;set;}
    }

    public class Items_S 
    {
        public String type{get;set;}
        public Object title{get;set;}
        public String path{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
    }

    public class InvestmentItems 
    {
        public String type{get;set;}
      //  public Object money_invested{get;set;}
        public String money_invested_currency_code{get;set;}
     //   public Object money_invested_usd{get;set;}
        public Funding_round funding_round{get;set;}
        public Invested_in invested_in{get;set;}
    }

    public class Items_U 
    {
        public String type{get;set;}
        public String name{get;set;}
        public String uuid{get;set;}
        public String path{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
    }

    public class Items_V 
    {
        public String type{get;set;}
        public String name{get;set;}
        public String street_1{get;set;}
        public Object street_2{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
        public String city{get;set;}
        public String city_uuid{get;set;}
        public String city_path{get;set;}
        public String region{get;set;}
        public String country_code{get;set;}
    }

    public class Items_W 
    {
        public String type{get;set;}
        public String name{get;set;}
        public String street_1{get;set;}
        public String street_2{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
        public String city{get;set;}
        public String city_uuid{get;set;}
        public String city_path{get;set;}
        public String region{get;set;}
        public String country_code{get;set;}
    }

    public class Items_X 
    {
        public String announced_on{get;set;}
        public String type{get;set;}
        public String name{get;set;}
        public String path{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
    }

    public class Past_team 
    {
        public Paging paging{get;set;}
        public List<Items> items{get;set;}
    }

    public class Items_Y 
    {
        public String type{get;set;}
        public String name{get;set;}
        public String path{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
    }

    public class Items_Z 
    {
        public String first_name{get;set;}
        public String last_name{get;set;}
        public String title{get;set;}
        public Object started_on{get;set;}
        public String path{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
    }

    public class Relationships 
    {
        public Past_team past_team{get;set;}
        public Board_members_and_advisors board_members_and_advisors{get;set;}
        public Sub_organizations sub_organizations{get;set;}
        public Board_members_and_advisors current_team{get;set;}
        public Acquisitions acquisitions{get;set;}
        public Sub_organizations competitors{get;set;}
        public Offices offices{get;set;}
        public Headquarters headquarters{get;set;}
        public Sub_organizations funding_rounds{get;set;}
        public Categories categories{get;set;}
        public Sub_organizations members{get;set;}
        public Sub_organizations customers{get;set;}
        public Investments investments{get;set;}
        public Sub_organizations founders{get;set;}
        public Sub_organizations ipo{get;set;}
        public Sub_organizations products{get;set;}
        public Primary_image primary_image{get;set;}
        public Primary_image images{get;set;}
        public Websites websites{get;set;}
        public News news{get;set;}
    }

    public class Invested_in 
    {
        public String type{get;set;}
        public String name{get;set;}
        public String path{get;set;}
    }

    public class Items 
    {
        public String first_name{get;set;}
        public String last_name{get;set;}
        public String title{get;set;}
        public String started_on{get;set;}
        public String ended_on{get;set;}
        public String path{get;set;}
        public Integer created_at{get;set;}
        public Integer updated_at{get;set;}
    }

    public class Investments 
    {
        public Paging paging{get;set;}
        public List<InvestmentItems> items{get;set;}
    }

    public class Acquisitions 
    {
        public Paging paging{get;set;}
        public List<Items_X> items{get;set;}
    }

    public class Headquarters 
    {
        public Paging paging{get;set;}
        public List<Items_V> items{get;set;}
    }

    public class Offices 
    {
        public Paging paging{get;set;}
        public List<Items_W> items{get;set;}
    }

    public class Websites 
    {
        public Paging paging{get;set;}
        public List<Items_R> items{get;set;}
    }

    public Metadata metadata {get;set;}
    public Data data{get;set;}
    public Properties properties{get;set;}
    public Relationships relationships{get;set;}
    public Board_members_and_advisors current_team{get;set;}
    public Primary_image Primary_image {get;set;}
    public Board_members_and_advisors Board_members_and_advisors {get;set;}
    public Websites Websites {get;set;}
    public Offices Offices {get;set;}
    public Headquarters Headquarters {get;set;}
    public Acquisitions  Acquisitions {get;set;}
    public Investments Investments {get;set;}
    public Past_team past_team{get;set;}
    public Sub_organizations funding_rounds{get;set;}
    public Categories categories{get;set;}
    public Sub_organizations members{get;set;}
    public Sub_organizations customers{get;set;}
    public Sub_organizations founders{get;set;}
    public Sub_organizations ipo{get;set;}
    public Sub_organizations products{get;set;}
    public Primary_image images{get;set;}
    public News news{get;set;}


    public class Primary_image 
    {
        public Paging paging{get;set;}
        public List<Items_S> items{get;set;}
    }

    public class Metadata 
    {
        public Integer version {get;set;}
        public String www_path_prefix{get;set;}
        public String api_path_prefix{get;set;}
        public String image_path_prefix{get;set;}
    }

    public class Board_members_and_advisors 
    {
        public Paging paging{get;set;}
        //public List<Items_Z> items{get;set;}
        public List<Items> items{get;set;}
    }
    
     public class current_team 
     {
        public Paging paging{get;set;}
        //public List<Items_Z> items{get;set;}
        public List<Items> items{get;set;}
    }


    
    public static OrganizationCrunch parse(String json) {
        return (OrganizationCrunch) System.JSON.deserialize(json, OrganizationCrunch.class);
    }
    /*
    static testMethod void testParse() {
        String json = '{'+
        ' \"metadata\": {'+
        '  \"version\": 2,'+
        '  \"www_path_prefix\": \"http://www.crunchbase.com/\",'+
        '  \"api_path_prefix\": \"http://api.crunchbase.com/v/2/\",'+
        '  \"image_path_prefix\": \"http://images.crunchbase.com/\"'+
        ' },'+
        ' \"data\": {'+
        '  \"uuid\": \"6acfa7da1dbd936ed985cf07a1b27711\",'+
        '  \"type\": \"Organization\",'+
        '  \"properties\": {'+
        '   \"role_company\": true,'+
        '   \"email_address\": \"google@google.com\",'+
        '   \"description\": \"Google provides search and advertising services, which together aim to organize and monetize the world\'s information. In addition to its dominant search engine, it offers a plethora of online tools and platforms including: Gmail, Maps, YouTube, and Google+, the company\'s extension into the social space. Most of its Web-based products are free, funded by Google\'s highly integrated online advertising platforms AdWords and AdSense. Google promotes the idea that advertising should be highly targeted and relevant to users thus providing them with a rich source of information. \\n\\nGoogle has also made strong moves into the web-based apps space with acquisitions of Jotspot (documents), 2Web Technologies (spreadsheets) and Zenter (presentations). The company has also made a splash with the acquisitions of YouTube, DoubleClick and Feedburner. \\n\",'+
        '   \"short_description\": \"Google is a search and advertising service provider that aims to organize and monetize the world’s information.\",'+
        '   \"founded_on_day\": 7,'+
        '   \"founded_on_month\": 9,'+
        '   \"founded_on_year\": 1998,'+
        '   \"founded_on\": \"1998-09-07\",'+
        '   \"founded_on_trust_code\": 7,'+
        '   \"permalink\": \"google\",'+
        '   \"primary_role\": \"company\",'+
        '   \"is_closed\": false,'+
        '   \"closed_on_trust_code\": 0,'+
        '   \"homepage_url\": \"http://www.google.com\",'+
        '   \"name\": \"Google\",'+
        '   \"closed_on_day\": null,'+
        '   \"closed_on_month\": null,'+
        '   \"closed_on_year\": null,'+
        '   \"closed_on\": null,'+
        '   \"role_investor\": true,'+
        '   \"secondary_role_for_profit\": true,'+
        '   \"num_employees_min\": 10001,'+
        '   \"num_employees_max\": 1000000,'+
        '   \"created_at\": 1398010616,'+
        '   \"updated_at\": 1414412884,'+
        '   \"total_funding_usd\": 25100000,'+
        '   \"number_of_investments\": 34,'+
        '   \"stock_symbol\": \"GOOG\",'+
        '   \"number_of_employees\": 49000'+
        '  },'+
        '  \"relationships\": {'+
        '   \"past_team\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 991,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/past_team\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"first_name\": \"Maarten\",'+
        '      \"last_name\": \"\'t Hooft\",'+
        '      \"title\": \"Technical Program Manager\",'+
        '      \"started_on\": \"2009-06-01\",'+
        '      \"ended_on\": \"2013-02-28\",'+
        '      \"path\": \"person/maarten-t-hooft\",'+
        '      \"created_at\": 1378733362,'+
        '      \"updated_at\": 1411112348'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Mohammed\",'+
        '      \"last_name\": \"Abdoolcarim\",'+
        '      \"title\": \"Product Guy\",'+
        '      \"started_on\": \"2004-01-01\",'+
        '      \"ended_on\": \"2008-01-01\",'+
        '      \"path\": \"person/mohammed-abdoolcarim\",'+
        '      \"created_at\": 1230106363,'+
        '      \"updated_at\": 1397989072'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Kurt\",'+
        '      \"last_name\": \"Abrahamson\",'+
        '      \"title\": \"Director, Sales Operations, North America, Director, Global Sales & Operations Strategy, Director, Content Media Group\",'+
        '      \"started_on\": \"2003-01-01\",'+
        '      \"ended_on\": \"2010-01-01\",'+
        '      \"path\": \"person/kurt-abrahamson\",'+
        '      \"created_at\": 1262129897,'+
        '      \"updated_at\": 1398010518'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Justin\",'+
        '      \"last_name\": \"Abrahms\",'+
        '      \"title\": \"Software Engineer\",'+
        '      \"started_on\": \"2011-07-01\",'+
        '      \"ended_on\": \"2012-08-01\",'+
        '      \"path\": \"person/justin-abrahms\",'+
        '      \"created_at\": 1359805053,'+
        '      \"updated_at\": 1397989201'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Anish\",'+
        '      \"last_name\": \"Acharya\",'+
        '      \"title\": \"Lead Product Manager, Google+ Mobile\",'+
        '      \"started_on\": \"2012-05-01\",'+
        '      \"ended_on\": \"2012-10-01\",'+
        '      \"path\": \"person/anish-acharya\",'+
        '      \"created_at\": 1271452284,'+
        '      \"updated_at\": 1413872706'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Matt\",'+
        '      \"last_name\": \"Ackley\",'+
        '      \"title\": \"Managing Director - Media and Platforms Market Development\",'+
        '      \"started_on\": \"2011-01-01\",'+
        '      \"ended_on\": \"2012-01-01\",'+
        '      \"path\": \"person/matt-ackley\",'+
        '      \"created_at\": 1372363219,'+
        '      \"updated_at\": 1397989306'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Michael\",'+
        '      \"last_name\": \"Adair\",'+
        '      \"title\": \"Head of Sales Finance, North America\",'+
        '      \"started_on\": null,'+
        '      \"ended_on\": null,'+
        '      \"path\": \"person/michael-adair\",'+
        '      \"created_at\": 1216818260,'+
        '      \"updated_at\": 1397988871'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Cameron\",'+
        '      \"last_name\": \"Adams\",'+
        '      \"title\": \"UI Designer\",'+
        '      \"started_on\": \"2008-01-01\",'+
        '      \"ended_on\": \"2011-06-01\",'+
        '      \"path\": \"person/cameron-adams\",'+
        '      \"created_at\": 1372107394,'+
        '      \"updated_at\": 1400812504'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"board_members_and_advisors\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 18,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/board_members_and_advisors\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"first_name\": \"Jeffrey\",'+
        '      \"last_name\": \"Ullman\",'+
        '      \"title\": \"Advisor\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/dr-jeffrey-ullman\",'+
        '      \"created_at\": 1366900742,'+
        '      \"updated_at\": 1398010476'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Michael\",'+
        '      \"last_name\": \"Moritz\",'+
        '      \"title\": \"Member of the Board of Directors\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/michael-moritz\",'+
        '      \"created_at\": 1202477603,'+
        '      \"updated_at\": 1410255971'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Misty\",'+
        '      \"last_name\": \"Locke\",'+
        '      \"title\": \"Advisory Boards\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/misty-locke\",'+
        '      \"created_at\": 1250494980,'+
        '      \"updated_at\": 1397989071'+
        '     },'+
        '     {'+
        '      \"first_name\": \"David\",'+
        '      \"last_name\": \"Bell\",'+
        '      \"title\": \"Board Member\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/david-bell-4\",'+
        '      \"created_at\": 1308994499,'+
        '      \"updated_at\": 1397989624'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Dario\",'+
        '      \"last_name\": \"Freddi\",'+
        '      \"title\": \"Summer of Code Mentor\",'+
        '      \"started_on\": \"2009-04-01\",'+
        '      \"path\": \"person/dario-freddi\",'+
        '      \"created_at\": 1369113281,'+
        '      \"updated_at\": 1412225722'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Al\",'+
        '      \"last_name\": \"Gore\",'+
        '      \"title\": \"Senior Advisor\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/al-gore\",'+
        '      \"created_at\": 1201725592,'+
        '      \"updated_at\": 1412363552'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Shirley\",'+
        '      \"last_name\": \"M. Tilghman\",'+
        '      \"title\": \"Board\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/shirley-m-tilghman\",'+
        '      \"created_at\": 1203702612,'+
        '      \"updated_at\": 1397989344'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Paul\",'+
        '      \"last_name\": \"S. Otellini\",'+
        '      \"title\": \"Board\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/paul-s-otellini\",'+
        '      \"created_at\": 1203702612,'+
        '      \"updated_at\": 1397989344'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"sub_organizations\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 2,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/sub_organizations\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Google[x]\",'+
        '      \"path\": \"organization/google-x\",'+
        '      \"created_at\": 1368272768,'+
        '      \"updated_at\": 1411550773'+
        '     },'+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Google Ventures\",'+
        '      \"path\": \"organization/google-ventures\",'+
        '      \"created_at\": 1238511781,'+
        '      \"updated_at\": 1414123254'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"current_team\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 361,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/current_team\",'+
        '     \"sort_order\": \"custom\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"first_name\": \"Larry\",'+
        '      \"last_name\": \"Page\",'+
        '      \"title\": \"CEO & Co-Founder\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/larry-page\",'+
        '      \"created_at\": 1398010514,'+
        '      \"updated_at\": 1413885967'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Eric\",'+
        '      \"last_name\": \"Schmidt\",'+
        '      \"title\": \"Executive Chairman\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/eric-schmidt\",'+
        '      \"created_at\": 1187447757,'+
        '      \"updated_at\": 1409289810'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Sergey\",'+
        '      \"last_name\": \"Brin\",'+
        '      \"title\": \"Co-Founder, President of Technology\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/sergey-brin\",'+
        '      \"created_at\": 1187447819,'+
        '      \"updated_at\": 1402069451'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Omid\",'+
        '      \"last_name\": \"Kordestani\",'+
        '      \"title\": \"Senior VP - Global Sales & Business Dev\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/omid-kordestani\",'+
        '      \"created_at\": 1187448064,'+
        '      \"updated_at\": 1400384781'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Shona\",'+
        '      \"last_name\": \"Brown\",'+
        '      \"title\": \"Senior VP - Business Operations\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/shona-brown\",'+
        '      \"created_at\": 1187448100,'+
        '      \"updated_at\": 1397988998'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Alan\",'+
        '      \"last_name\": \"Eustace\",'+
        '      \"title\": \"Senior VP - Engineering and Research\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/alan-eustace\",'+
        '      \"created_at\": 1187448131,'+
        '      \"updated_at\": 1407733291'+
        '     },'+
        '     {'+
        '      \"first_name\": \"David\",'+
        '      \"last_name\": \"Lawee\",'+
        '      \"title\": \"Vice President Corporate Development\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/david-lawee\",'+
        '      \"created_at\": 1203223974,'+
        '      \"updated_at\": 1398010568'+
        '     },'+
        '     {'+
        '      \"first_name\": \"Benjamin\",'+
        '      \"last_name\": \"Fried\",'+
        '      \"title\": \"CIO\",'+
        '      \"started_on\": null,'+
        '      \"path\": \"person/benjamin-fried\",'+
        '      \"created_at\": 1209119667,'+
        '      \"updated_at\": 1397989019'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"acquisitions\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 166,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/acquisitions\",'+
        '     \"sort_order\": \"announced_on? desc\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"announced_on\": \"2014-10-21\",'+
        '      \"type\": \"Acquisition\",'+
        '      \"name\": \"Acquisition\",'+
        '      \"path\": \"acquisition/14d8dd6f06ed08d9358deee8baedde06\",'+
        '      \"created_at\": 1413947623,'+
        '      \"updated_at\": 1413948052'+
        '     },'+
        '     {'+
        '      \"announced_on\": \"2014-09-11\",'+
        '      \"type\": \"Acquisition\",'+
        '      \"name\": \"Acquisition\",'+
        '      \"path\": \"acquisition/2465608e9bbe3207f363c3fcf79a7e81\",'+
        '      \"created_at\": 1410492253,'+
        '      \"updated_at\": 1410492680'+
        '     },'+
        '     {'+
        '      \"announced_on\": \"2014-09-11\",'+
        '      \"type\": \"Acquisition\",'+
        '      \"name\": \"Acquisition\",'+
        '      \"path\": \"acquisition/e4044368475b0ad0744fbf90fcb46473\",'+
        '      \"created_at\": 1410460701,'+
        '      \"updated_at\": 1410461928'+
        '     },'+
        '     {'+
        '      \"announced_on\": \"2014-08-26\",'+
        '      \"type\": \"Acquisition\",'+
        '      \"name\": \"Acquisition\",'+
        '      \"path\": \"acquisition/40bfab5515f6c307902e4e0e3a704ce3\",'+
        '      \"created_at\": 1409108994,'+
        '      \"updated_at\": 1409110337'+
        '     },'+
        '     {'+
        '      \"announced_on\": \"2014-08-22\",'+
        '      \"type\": \"Acquisition\",'+
        '      \"name\": \"Acquisition\",'+
        '      \"path\": \"acquisition/3882f61b4b1ae11d3056dda575d05837\",'+
        '      \"created_at\": 1408739763,'+
        '      \"updated_at\": 1410211349'+
        '     },'+
        '     {'+
        '      \"announced_on\": \"2014-08-15\",'+
        '      \"type\": \"Acquisition\",'+
        '      \"name\": \"Acquisition\",'+
        '      \"path\": \"acquisition/a27be7ac71dfe52b178cd92d50760312\",'+
        '      \"created_at\": 1408169339,'+
        '      \"updated_at\": 1408169339'+
        '     },'+
        '     {'+
        '      \"announced_on\": \"2014-08-06\",'+
        '      \"type\": \"Acquisition\",'+
        '      \"name\": \"Acquisition\",'+
        '      \"path\": \"acquisition/832aa44dd0d0d22a6a9dcb26f4c798d5\",'+
        '      \"created_at\": 1407380053,'+
        '      \"updated_at\": 1407380053'+
        '     },'+
        '     {'+
        '      \"announced_on\": \"2014-08-01\",'+
        '      \"type\": \"Acquisition\",'+
        '      \"name\": \"Acquisition\",'+
        '      \"path\": \"acquisition/bb4c36eefb3cbf980091e91de9867cc2\",'+
        '      \"created_at\": 1407361499,'+
        '      \"updated_at\": 1407380787'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"competitors\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 42,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/competitors\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Tencent\",'+
        '      \"path\": \"organization/tencent\",'+
        '      \"created_at\": 1402102410,'+
        '      \"updated_at\": 1414401159'+
        '     },'+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Microsoft\",'+
        '      \"path\": \"organization/microsoft\",'+
        '      \"created_at\": 1399896058,'+
        '      \"updated_at\": 1414476297'+
        '     },'+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Cybozu, Inc.\",'+
        '      \"path\": \"organization/cybozu-inc\",'+
        '      \"created_at\": 1383872294,'+
        '      \"updated_at\": 1411774406'+
        '     },'+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Twiddle\",'+
        '      \"path\": \"organization/twiddle\",'+
        '      \"created_at\": 1380712472,'+
        '      \"updated_at\": 1413909181'+
        '     },'+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"for{get;set;} to (do)\",'+
        '      \"path\": \"organization/for-to-do\",'+
        '      \"created_at\": 1329301941,'+
        '      \"updated_at\": 1411755336'+
        '     },'+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"just.me 2014 Inc\",'+
        '      \"path\": \"organization/justme\",'+
        '      \"created_at\": 1312022876,'+
        '      \"updated_at\": 1413781497'+
        '     },'+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Ness Computing\",'+
        '      \"path\": \"organization/ness-computing\",'+
        '      \"created_at\": 1311163171,'+
        '      \"updated_at\": 1409177403'+
        '     },'+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Mail.com Media Corporation\",'+
        '      \"path\": \"organization/mail-com-media-corporation\",'+
        '      \"created_at\": 1268200289,'+
        '      \"updated_at\": 1412049268'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"offices\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 70,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/offices\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Google Bucharest\",'+
        '      \"street_1\": \"Str. C. A. Rosetti nr. 17\",'+
        '      \"street_2\": \"Sector 2\",'+
        '      \"created_at\": 1406810524,'+
        '      \"updated_at\": 1412727750,'+
        '      \"city\": \"Bucharest\",'+
        '      \"city_uuid\": \"2311a247a3b90bf1ba931616b25d432d\",'+
        '      \"city_path\": \"location/bucharest/2311a247a3b90bf1ba931616b25d432d\",'+
        '      \"region\": \"Bucuresti\",'+
        '      \"country_code\": \"ROM\"'+
        '     },'+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Google Japan\",'+
        '      \"street_1\": \"6F Cerulean Tower, 26-1 Sakuragaoka-cho\",'+
        '      \"street_2\": null,'+
        '      \"created_at\": 1400263887,'+
        '      \"updated_at\": 1411755630,'+
        '      \"city\": \"Tokyo\",'+
        '      \"city_uuid\": \"127ba62dd40a3d1242c0e606f9fa9440\",'+
        '      \"city_path\": \"location/tokyo/127ba62dd40a3d1242c0e606f9fa9440\",'+
        '      \"region\": \"Tokyo\",'+
        '      \"country_code\": \"JPN\"'+
        '     },'+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Headquarters - Googleplex\",'+
        '      \"street_1\": \"1600 Amphitheatre Pkwy\",'+
        '      \"street_2\": null,'+
        '      \"created_at\": 1399932975,'+
        '      \"updated_at\": 1406880467,'+
        '      \"city\": \"Mountain View\",'+
        '      \"city_uuid\": \"37bfe551197e02269a805d7bec8a50dd\",'+
        '      \"city_path\": \"location/mountain-view/37bfe551197e02269a805d7bec8a50dd\",'+
        '      \"region\": \"California\",'+
        '      \"country_code\": \"USA\"'+
        '     },'+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Google World Headquarters\",'+
        '      \"street_1\": \"1600 Amphitheatre Pkwy\",'+
        '      \"street_2\": null,'+
        '      \"created_at\": 1399916259,'+
        '      \"updated_at\": 1406881329,'+
        '      \"city\": \"Mountain View\",'+
        '      \"city_uuid\": \"37bfe551197e02269a805d7bec8a50dd\",'+
        '      \"city_path\": \"location/mountain-view/37bfe551197e02269a805d7bec8a50dd\",'+
        '      \"region\": \"California\",'+
        '      \"country_code\": \"USA\"'+
        '     },'+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Google Dubai\",'+
        '      \"street_1\": \"Building No 17, Dubai Internet City\",'+
        '      \"street_2\": \"First Floor\",'+
        '      \"created_at\": 1213154527,'+
        '      \"updated_at\": 1404294125,'+
        '      \"city\": \"Dubai\",'+
        '      \"city_uuid\": \"0e8010ee2f5938dbb7e2998e92dde222\",'+
        '      \"city_path\": \"location/dubai/0e8010ee2f5938dbb7e2998e92dde222\",'+
        '      \"region\": \"Dubai\",'+
        '      \"country_code\": \"ARE\"'+
        '     },'+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Google Istanbul\",'+
        '      \"street_1\": \"Kanyon Ofis Binasi Kat. 6, Buyukdere Cad. No. 185\",'+
        '      \"street_2\": null,'+
        '      \"created_at\": 1213154527,'+
        '      \"updated_at\": 1404294215,'+
        '      \"city\": \"Istanbul\",'+
        '      \"city_uuid\": \"6618468699ba3fd26be7c4a96c04812a\",'+
        '      \"city_path\": \"location/istanbul/6618468699ba3fd26be7c4a96c04812a\",'+
        '      \"region\": \"Istanbul\",'+
        '      \"country_code\": \"TUR\"'+
        '     },'+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Google Haifa\",'+
        '      \"street_1\": \"Building 30, MATAM, Advanced Technology Center\",'+
        '      \"street_2\": null,'+
        '      \"created_at\": 1213154526,'+
        '      \"updated_at\": 1404294265,'+
        '      \"city\": \"Haifa\",'+
        '      \"city_uuid\": \"679f703e52529e88a5a701855b36d374\",'+
        '      \"city_path\": \"location/haifa/679f703e52529e88a5a701855b36d374\",'+
        '      \"region\": \"Hefa\",'+
        '      \"country_code\": \"ISR\"'+
        '     },'+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Google Mexico\",'+
        '      \"street_1\": \"Blvd. Manuel Avila Camacho #36\",'+
        '      \"street_2\": null,'+
        '      \"created_at\": 1213154526,'+
        '      \"updated_at\": 1413832719,'+
        '      \"city\": \"Mexico City\",'+
        '      \"city_uuid\": \"01394be19ab607ca91466b8db8add1b5\",'+
        '      \"city_path\": \"location/mexico-city/01394be19ab607ca91466b8db8add1b5\",'+
        '      \"region\": \"Distrito Federal\",'+
        '      \"country_code\": \"MEX\"'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"headquarters\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 1,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/headquarters\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Address\",'+
        '      \"name\": \"Google World Headquarters\",'+
        '      \"street_1\": \"1600 Amphitheatre Pkwy\",'+
        '      \"street_2\": null,'+
        '      \"created_at\": 1399916259,'+
        '      \"updated_at\": 1406881329,'+
        '      \"city\": \"Mountain View\",'+
        '      \"city_uuid\": \"37bfe551197e02269a805d7bec8a50dd\",'+
        '      \"city_path\": \"location/mountain-view/37bfe551197e02269a805d7bec8a50dd\",'+
        '      \"region\": \"California\",'+
        '      \"country_code\": \"USA\"'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"funding_rounds\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 2,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/funding_rounds\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"FundingRound\",'+
        '      \"name\": \"Google raises 0 in angel round\",'+
        '      \"path\": \"funding-round/eb6c4d28ae50cd54ca55186d2955e8c3\",'+
        '      \"created_at\": 1398979110,'+
        '      \"updated_at\": 1400601270'+
        '     },'+
        '     {'+
        '      \"type\": \"FundingRound\",'+
        '      \"name\": \"Google raises 25000000 in venture round\",'+
        '      \"path\": \"funding-round/6c4715f941c0136fd5e4ac72ddf57d99\",'+
        '      \"created_at\": 1187427842,'+
        '      \"updated_at\": 1398009881'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"categories\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 6,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/categories\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Category\",'+
        '      \"name\": \"Software\",'+
        '      \"uuid\": \"c08b5441a05b9777b7a6012728caddd9\",'+
        '      \"path\": \"category/software/c08b5441a05b9777b7a6012728caddd9\",'+
        '      \"created_at\": 1397980727,'+
        '      \"updated_at\": 1414484821'+
        '     },'+
        '     {'+
        '      \"type\": \"Category\",'+
        '      \"name\": \"Video Streaming\",'+
        '      \"uuid\": \"b1b3b2d785ed2cb1fc603e2b6a3b5ddd\",'+
        '      \"path\": \"category/video streaming/b1b3b2d785ed2cb1fc603e2b6a3b5ddd\",'+
        '      \"created_at\": 1397980727,'+
        '      \"updated_at\": 1414475877'+
        '     },'+
        '     {'+
        '      \"type\": \"Category\",'+
        '      \"name\": \"Email\",'+
        '      \"uuid\": \"687e34ef30e2af08a178436d6b53d633\",'+
        '      \"path\": \"category/email/687e34ef30e2af08a178436d6b53d633\",'+
        '      \"created_at\": 1397980727,'+
        '      \"updated_at\": 1414402249'+
        '     },'+
        '     {'+
        '      \"type\": \"Category\",'+
        '      \"name\": \"Search\",'+
        '      \"uuid\": \"0d39287e5b1377a6970274294daded43\",'+
        '      \"path\": \"category/search/0d39287e5b1377a6970274294daded43\",'+
        '      \"created_at\": 1397980727,'+
        '      \"updated_at\": 1414475216'+
        '     },'+
        '     {'+
        '      \"type\": \"Category\",'+
        '      \"name\": \"Information Technology\",'+
        '      \"uuid\": \"dbca89faf0835438b4add3fdeceb78e7\",'+
        '      \"path\": \"category/information technology/dbca89faf0835438b4add3fdeceb78e7\",'+
        '      \"created_at\": 1397980726,'+
        '      \"updated_at\": 1414484768'+
        '     },'+
        '     {'+
        '      \"type\": \"Category\",'+
        '      \"name\": \"Blogging Platforms\",'+
        '      \"uuid\": \"1ded70549e6d2ede57adc95e83be0c06\",'+
        '      \"path\": \"category/blogging platforms/1ded70549e6d2ede57adc95e83be0c06\",'+
        '      \"created_at\": 1397980726,'+
        '      \"updated_at\": 1414143218'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"members\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 1,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/members\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Google Plus\",'+
        '      \"path\": \"organization/google-plus\",'+
        '      \"created_at\": 1319786149,'+
        '      \"updated_at\": 1408886532'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"customers\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 1,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/customers\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Organization\",'+
        '      \"name\": \"Ouyeaa\",'+
        '      \"path\": \"organization/ouyeaa\",'+
        '      \"created_at\": 1408010328,'+
        '      \"updated_at\": 1414019019'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"investments\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 34,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/investments\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"InvestorInvestment\",'+
        '      \"money_invested\": null,'+
        '      \"money_invested_currency_code\": \"USD\",'+
        '      \"money_invested_usd\": null,'+
        '      \"funding_round\": {'+
        '       \"path\": \"funding-round/5aa6d03eddafd1e9f9ac9ca6693b0f65\"'+
        '      },'+
        '      \"invested_in\": {'+
        '       \"type\": \"Organization\",'+
        '       \"name\": \"Magic Leap\",'+
        '       \"path\": \"organization/magic-leap\"'+
        '      }'+
        '     },'+
        '     {'+
        '      \"type\": \"InvestorInvestment\",'+
        '      \"money_invested\": null,'+
        '      \"money_invested_currency_code\": \"USD\",'+
        '      \"money_invested_usd\": null,'+
        '      \"funding_round\": {'+
        '       \"path\": \"funding-round/eedd87ee7190f9cd922cf34cde50c3eb\"'+
        '      },'+
        '      \"invested_in\": {'+
        '       \"type\": \"Organization\",'+
        '       \"name\": \"Hello Doctor\",'+
        '       \"path\": \"organization/hello-doctor\"'+
        '      }'+
        '     },'+
        '     {'+
        '      \"type\": \"InvestorInvestment\",'+
        '      \"money_invested\": null,'+
        '      \"money_invested_currency_code\": \"USD\",'+
        '      \"money_invested_usd\": null,'+
        '      \"funding_round\": {'+
        '       \"path\": \"funding-round/82fa65e9a85451eb677344853f78c916\"'+
        '      },'+
        '      \"invested_in\": {'+
        '       \"type\": \"Organization\",'+
        '       \"name\": \"Dianping\",'+
        '       \"path\": \"organization/dianping\"'+
        '      }'+
        '     },'+
        '     {'+
        '      \"type\": \"InvestorInvestment\",'+
        '      \"money_invested\": 280000000,'+
        '      \"money_invested_currency_code\": \"USD\",'+
        '      \"money_invested_usd\": 280000000,'+
        '      \"funding_round\": {'+
        '       \"path\": \"funding-round/519d19ee82f49c43ca377a2f359f5da6\"'+
        '      },'+
        '      \"invested_in\": {'+
        '       \"type\": \"Organization\",'+
        '       \"name\": \"SolarCity\",'+
        '       \"path\": \"organization/solarcity\"'+
        '      }'+
        '     },'+
        '     {'+
        '      \"type\": \"InvestorInvestment\",'+
        '      \"money_invested\": null,'+
        '      \"money_invested_currency_code\": \"USD\",'+
        '      \"money_invested_usd\": null,'+
        '      \"funding_round\": {'+
        '       \"path\": \"funding-round/519d19ee82f49c43ca377a2f359f5da6\"'+
        '      },'+
        '      \"invested_in\": {'+
        '       \"type\": \"Organization\",'+
        '       \"name\": \"SolarCity\",'+
        '       \"path\": \"organization/solarcity\"'+
        '      }'+
        '     },'+
        '     {'+
        '      \"type\": \"InvestorInvestment\",'+
        '      \"money_invested\": null,'+
        '      \"money_invested_currency_code\": \"USD\",'+
        '      \"money_invested_usd\": null,'+
        '      \"funding_round\": {'+
        '       \"path\": \"funding-round/c2fe2fec755b3aa9fca14db17420fda8\"'+
        '      },'+
        '      \"invested_in\": {'+
        '       \"type\": \"Organization\",'+
        '       \"name\": \"Vittana\",'+
        '       \"path\": \"organization/vittana\"'+
        '      }'+
        '     },'+
        '     {'+
        '      \"type\": \"InvestorInvestment\",'+
        '      \"money_invested\": null,'+
        '      \"money_invested_currency_code\": \"USD\",'+
        '      \"money_invested_usd\": null,'+
        '      \"funding_round\": {'+
        '       \"path\": \"funding-round/5fbefd87314d9019d85e24d159d9c6eb\"'+
        '      },'+
        '      \"invested_in\": {'+
        '       \"type\": \"Organization\",'+
        '       \"name\": \"BrightSource Energy\",'+
        '       \"path\": \"organization/brightsource-energy\"'+
        '      }'+
        '     },'+
        '     {'+
        '      \"type\": \"InvestorInvestment\",'+
        '      \"money_invested\": null,'+
        '      \"money_invested_currency_code\": \"USD\",'+
        '      \"money_invested_usd\": null,'+
        '      \"funding_round\": {'+
        '       \"path\": \"funding-round/cf8299f657f7fd4cf01054ee1934109c\"'+
        '      },'+
        '      \"invested_in\": {'+
        '       \"type\": \"Organization\",'+
        '       \"name\": \"Zynga\",'+
        '       \"path\": \"organization/zynga\"'+
        '      }'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"founders\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 2,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/founders\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Person\",'+
        '      \"name\": \"Larry Page\",'+
        '      \"path\": \"person/larry-page\",'+
        '      \"created_at\": 1398010514,'+
        '      \"updated_at\": 1413885967'+
        '     },'+
        '     {'+
        '      \"type\": \"Person\",'+
        '      \"name\": \"Sergey Brin\",'+
        '      \"path\": \"person/sergey-brin\",'+
        '      \"created_at\": 1187447819,'+
        '      \"updated_at\": 1402069451'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"ipo\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 1,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/ipo\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Ipo\",'+
        '      \"name\": \"Went public on August 19, 2004\",'+
        '      \"path\": \"ipo/bee91e2e4cfb70deb19d42e4bf991848\",'+
        '      \"created_at\": 1401077868,'+
        '      \"updated_at\": 1407597940'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"products\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 116,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/products\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"Product\",'+
        '      \"name\": \"Field Trip\",'+
        '      \"path\": \"product/field-trip\",'+
        '      \"created_at\": 1414393923,'+
        '      \"updated_at\": 1414394082'+
        '     },'+
        '     {'+
        '      \"type\": \"Product\",'+
        '      \"name\": \"AngularJS\",'+
        '      \"path\": \"product/angularjs\",'+
        '      \"created_at\": 1414238636,'+
        '      \"updated_at\": 1414239014'+
        '     },'+
        '     {'+
        '      \"type\": \"Product\",'+
        '      \"name\": \"Primer\",'+
        '      \"path\": \"product/primer\",'+
        '      \"created_at\": 1412926422,'+
        '      \"updated_at\": 1412926511'+
        '     },'+
        '     {'+
        '      \"type\": \"Product\",'+
        '      \"name\": \"Google Play Newsstand\",'+
        '      \"path\": \"product/google-play-newsstand\",'+
        '      \"created_at\": 1411492746,'+
        '      \"updated_at\": 1411550456'+
        '     },'+
        '     {'+
        '      \"type\": \"Product\",'+
        '      \"name\": \"Mythreyi Promoters and Developers\",'+
        '      \"path\": \"product/mythreyi-promoters-and-developer\",'+
        '      \"created_at\": 1408359909,'+
        '      \"updated_at\": 1408362943'+
        '     },'+
        '     {'+
        '      \"type\": \"Product\",'+
        '      \"name\": \"Classroom\",'+
        '      \"path\": \"product/classroom\",'+
        '      \"created_at\": 1407869802,'+
        '      \"updated_at\": 1408322335'+
        '     },'+
        '     {'+
        '      \"type\": \"Product\",'+
        '      \"name\": \"Google Analytics for iOS\",'+
        '      \"path\": \"product/google-analytics-for-ios\",'+
        '      \"created_at\": 1406028951,'+
        '      \"updated_at\": 1412592466'+
        '     },'+
        '     {'+
        '      \"type\": \"Product\",'+
        '      \"name\": \"Unmark for Chrome\",'+
        '      \"path\": \"product/unmark-for-chrome\",'+
        '      \"created_at\": 1405747264,'+
        '      \"updated_at\": 1412602593'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"primary_image\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 1,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/primary_image\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"ImageAsset\",'+
        '      \"title\": null,'+
        '      \"path\": \"image/upload/v1408578017/tjiikcwcsseopwkjav7e.png\",'+
        '      \"created_at\": 1398018474,'+
        '      \"updated_at\": 1408578019'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"images\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 1,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/images\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"type\": \"ImageAsset\",'+
        '      \"title\": null,'+
        '      \"path\": \"image/upload/v1405341394/gn2wkwdqoatwmosbemt7.png\",'+
        '      \"created_at\": 1405341512,'+
        '      \"updated_at\": 1405341512'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"websites\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 6,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/websites\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"url\": \"http://www.linkedin.com/company/google\",'+
        '      \"type\": \"WebPresence\",'+
        '      \"title\": \"linkedin\",'+
        '      \"created_at\": 1400229399,'+
        '      \"updated_at\": 1409459584'+
        '     },'+
        '     {'+
        '      \"url\": \"http://www.facebook.com/Google\",'+
        '      \"type\": \"WebPresence\",'+
        '      \"title\": \"facebook\",'+
        '      \"created_at\": 1400229399,'+
        '      \"updated_at\": 1409503265'+
        '     },'+
        '     {'+
        '      \"url\": \"http://vt.webrazzi.com/sirket/google-turkiye\",'+
        '      \"type\": \"WebPresence\",'+
        '      \"title\": \"angellist\",'+
        '      \"created_at\": 1397877760,'+
        '      \"updated_at\": 2014'+
        '     },'+
        '     {'+
        '      \"url\": \"http://twitter.com/google\",'+
        '      \"type\": \"WebPresence\",'+
        '      \"title\": \"twitter\",'+
        '      \"created_at\": 1183241892,'+
        '      \"updated_at\": 1409448320'+
        '     },'+
        '     {'+
        '      \"url\": \"http://googleblog.blogspot.com\",'+
        '      \"type\": \"WebPresence\",'+
        '      \"title\": \"blog\",'+
        '      \"created_at\": 1183241892,'+
        '      \"updated_at\": 1397987401'+
        '     },'+
        '     {'+
        '      \"url\": \"http://www.google.com\",'+
        '      \"type\": \"WebPresence\",'+
        '      \"title\": \"homepage\",'+
        '      \"created_at\": 1183241892,'+
        '      \"updated_at\": 1412379124'+
        '     }'+
        '    ]'+
        '   },'+
        '   \"news\": {'+
        '    \"paging\": {'+
        '     \"total_items\": 4592,'+
        '     \"first_page_url\": \"http://api.crunchbase.com/v/2/organization/google/news\",'+
        '     \"sort_order\": \"created_at DESC\"'+
        '    },'+
        '    \"items\": ['+
        '     {'+
        '      \"url\": \"http://techcrunch.com/2014/10/05/google-plans-to-hire-security-guards-as-employees-not-contractors/\",'+
        '      \"author\": null,'+
        '      \"posted_on\": \"2014-10-05\",'+
        '      \"type\": \"PressReference\",'+
        '      \"title\": \"Google Plans To Hire Security Guards As Employees, Not Contractors | TechCrunch\",'+
        '      \"created_at\": 1414412884,'+
        '      \"updated_at\": 1414412885'+
        '     },'+
        '     {'+
        '      \"url\": \"http://techcrunch.com/2014/10/08/google-turned-a-camel-into-a-street-view-car-to-map-the-liwa-desert/\",'+
        '      \"author\": null,'+
        '      \"posted_on\": \"2014-10-08\",'+
        '      \"type\": \"PressReference\",'+
        '      \"title\": \"Google Turned A Camel Into A Street View Car To Map The Liwa Desert | TechCrunch\",'+
        '      \"created_at\": 1414406355,'+
        '      \"updated_at\": 1414406355'+
        '     },'+
        '     {'+
        '      \"url\": \"http://techcrunch.com/2014/10/08/google-launches-new-50year-chromebooks-for-work-subscription-option/\",'+
        '      \"author\": null,'+
        '      \"posted_on\": \"2014-10-08\",'+
        '      \"type\": \"PressReference\",'+
        '      \"title\": \"Google Launches New $50/Year Chromebooks For Work Subscription Option | TechCrunch\",'+
        '      \"created_at\": 1414405136,'+
        '      \"updated_at\": 1414405137'+
        '     },'+
        '     {'+
        '      \"url\": \"http://techcrunch.com/2014/10/09/google-launches-mini-marketing-lessons-for-startups-with-new-mobile-app-google-primer/\",'+
        '      \"author\": null,'+
        '      \"posted_on\": \"2014-10-09\",'+
        '      \"type\": \"PressReference\",'+
        '      \"title\": \"Google Launches Mini-Marketing Lessons For Startups With New Mobile App, Google Primer | TechCrunch\",'+
        '      \"created_at\": 1414400730,'+
        '      \"updated_at\": 1414400730'+
        '     },'+
        '     {'+
        '      \"url\": \"http://techcrunch.com/2014/10/09/google-hangouts-is-now-a-dedicated-app-for-chrome-os-and-windows-pcs/\",'+
        '      \"author\": null,'+
        '      \"posted_on\": \"2014-10-09\",'+
        '      \"type\": \"PressReference\",'+
        '      \"title\": \"Google Hangouts Is Now A Dedicated App For Chrome OS And Windows PCs | TechCrunch\",'+
        '      \"created_at\": 1414400657,'+
        '      \"updated_at\": 1414400658'+
        '     },'+
        '     {'+
        '      \"url\": \"http://techcrunch.com/2014/10/09/googles-conversational-search-gets-smarter-adds-opentable-integration/\",'+
        '      \"author\": null,'+
        '      \"posted_on\": \"2014-10-09\",'+
        '      \"type\": \"PressReference\",'+
        '      \"title\": \"Google’s Conversational Search Gets Smarter, Adds OpenTable Integration | TechCrunch\",'+
        '      \"created_at\": 1414400224,'+
        '      \"updated_at\": 1414400224'+
        '     },'+
        '     {'+
        '      \"url\": \"http://techcrunch.com/2014/10/10/meerkats/\",'+
        '      \"author\": null,'+
        '      \"posted_on\": \"2014-10-10\",'+
        '      \"type\": \"PressReference\",'+
        '      \"title\": \"Another Google White Spaces Trial Brings You Live Meerkat Action From London Zoo | TechCrunch\",'+
        '      \"created_at\": 1414395972,'+
        '      \"updated_at\": 1414395972'+
        '     },'+
        '     {'+
        '      \"url\": \"http://techcrunch.com/2014/10/11/the-answer-engine-how-humans-can-provide-better-knowledge-than-algorithms/\",'+
        '      \"author\": null,'+
        '      \"posted_on\": \"2014-10-11\",'+
        '      \"type\": \"PressReference\",'+
        '      \"title\": \"The Answer Engine: How Humans Can Provide Better Knowledge Than Algorithms | TechCrunch\",'+
        '      \"created_at\": 1414391333,'+
        '      \"updated_at\": 1414391333'+
        '     }'+
        '    ]'+
        '   }'+
        '  }'+
        ' }'+
        '}'{get;set;}
        OrganizationCrunch obj = parse(json){get;set;}
        System.assert(obj != null){get;set;}
    }*/
}