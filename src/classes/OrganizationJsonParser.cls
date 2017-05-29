public class OrganizationJsonParser
{
        public data data{get;set;}
        public metadata metadata{get;set;}
    public class ipo
    {
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class competitors
    {
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class data
    {
        public String type{get;set;}
        public properties properties{get;set;}
        public relationships relationships{get;set;}
        public String uuid{get;set;}
    }
    public class funding_rounds
    {
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class founders{
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class sub_organizations{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class invested_in{
        public String type{get;set;}
        public String path{get;set;}
        public String name{get;set;}
    }
    public class offices{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class relationships{
        public founders founders{get;set;}
        public current_team current_team{get;set;}
        public offices offices{get;set;}
        public sub_organizations sub_organizations{get;set;}
        public board_members_and_advisors board_members_and_advisors{get;set;}
        public funding_rounds funding_rounds{get;set;}
        public images images{get;set;}
        public headquarters headquarters{get;set;}
        public categories categories{get;set;}
        public customers customers{get;set;}
        public past_team past_team{get;set;}
        public websites websites{get;set;}
        public acquisitions acquisitions{get;set;}
        public competitors competitors{get;set;}
        public products products{get;set;}
        public news news{get;set;}
        public primary_image primary_image{get;set;}
        public investments investments{get;set;}
        public members members{get;set;}
        public ipo ipo{get;set;}
    }
    public class products{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class paging
    {
    
        public Integer total_items{get;set;}
        public String sort_order{get;set;}
        public String first_page_url{get;set;}      
    
            }
    public class members{
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class metadata{
        public String www_path_prefix{get;set;}
        public String api_path_prefix{get;set;}
        public Integer version{get;set;}
        public String image_path_prefix{get;set;}
    }
    public class investments{
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class news{
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class funding_round{
        public String path{get;set;}
    }
    public class properties{
        public Integer founded_on_day{get;set;}
        public Boolean secondary_role_for_profit{get;set;}
        public Integer num_employees_max{get;set;}
        public Boolean role_company{get;set;}
        public Integer number_of_investments{get;set;}
        public Boolean role_investor{get;set;}
        public Integer num_employees_min{get;set;}
        public Boolean is_closed{get;set;}
        public Integer founded_on_year{get;set;}
        public String stock_symbol{get;set;}
        public Integer created_at{get;set;}
        public String primary_role{get;set;}
        public Integer closed_on_trust_code{get;set;}
        public String closed_on{get;set;}
        public String name{get;set;}
        public Integer updated_at{get;set;}
        public String description{get;set;}
        public String permalink{get;set;}
        public String closed_on_year{get;set;}
        public Integer total_funding_usd{get;set;}
        public String short_description{get;set;}
        public String email_address{get;set;}
        public String founded_on{get;set;}
        public Integer number_of_employees{get;set;}
        public Integer founded_on_month{get;set;}
        public String homepage_url{get;set;}
        public String closed_on_day{get;set;}
        public String closed_on_month{get;set;}
        public Integer founded_on_trust_code{get;set;}
    }
    public class websites{
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class customers{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class headquarters{
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class current_team{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class items{
        public Integer updated_at{get;set;}
        public Integer created_at{get;set;}
        public String type{get;set;}
        public String path{get;set;}
        public String first_name{get;set;}
        public String name{get;set;}
        public String title{get;set;}
    
        public String last_name{get;set;}
        public String started_on{get;set;}
        public String region{get;set;}
        public String street_2{get;set;}
        public String street_1{get;set;}

       public String city_uuid{get;set;}
        public String country_code{get;set;}
        public String city_path{get;set;}
        public String city{get;set;}
      
        public String ended_on{get;set;}
        public String url{get;set;}
        public String posted_on{get;set;}
        public String announced_on{get;set;}
        public String author{get;set;}
     
        public String money_invested_usd{get;set;}

        public funding_round funding_round{get;set;}
       
        public invested_in invested_in{get;set;}

      

        public String money_invested_currency_code{get;set;}
     }
    public class board_members_and_advisors
    {
        public paging paging{get;set;}
        public list<items> items{get;set;}
    }
    public class images{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class categories{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class past_team{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class primary_image{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
    public class acquisitions{
        public list<items> items{get;set;}
        public paging paging{get;set;}
    }
}