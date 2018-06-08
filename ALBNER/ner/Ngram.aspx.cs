using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace ALBNER.ner
{

    public partial class Ngram : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowSpecificNewsCnt();
                BindGridview();
            }
        }


        protected void ShowSpecificNewsCnt()
        {
            int news_id;
            news_id = Convert.ToInt32(Request.QueryString["id"]);

            using (MySqlConnection con = new MySqlConnection(constr))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand("sp_GetSpecificNews", con);
                cmd.CommandType = CommandType.StoredProcedure;
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@news_id", news_id);
                MySqlDataReader rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    string title = rd["title"].ToString();
                    h_news_title.InnerText = title;
                    string content = rd["content"].ToString();
                    ltl_newscontent.Text = string.Format("<p>{0}</p>",content.Replace("\r", "</p><p>"));
                }
                con.Close();     
            }
        }


        protected void BindGridview()
        {
            int news_id = Convert.ToInt32(Request.QueryString["id"]);
            int ngram_type = Convert.ToInt32(Request.QueryString["ngram_type"]);
            DataSet ds = new DataSet();
           
            using (MySqlConnection con = new MySqlConnection(constr))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand("sp_GetNgrams", con);
                cmd.CommandType = CommandType.StoredProcedure;
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@news_id", news_id);
                cmd.Parameters.AddWithValue("@ngram_type", ngram_type);
                da.Fill(ds);
                con.Close();
                gvNgrams.DataSource = ds;
                gvNgrams.DataBind();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "addColorScript", "HighlightUpperCaseInGV();", true);

            }
        }

        
        protected void Edit(object sender, EventArgs e)
        {
            using (GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent)
            {
                hfID.Value = row.Cells[0].Text;
                ddl_Entities.SelectedValue = row.Cells[2].Text;
                popup.Show();
            }
        }


    protected void Save(object sender, EventArgs e)  
    {  
        MySqlConnection con = new MySqlConnection(constr);
        con.Open();    
        MySqlCommand cmd = new MySqlCommand("sp_AnnotateEntity", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ngram_id", hfID.Value);
        cmd.Parameters.AddWithValue("@entity_type", ddl_Entities.SelectedValue);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        con.Close();  
        BindGridview(); 
    }

    protected void GoToNextNews(object s, EventArgs e)
    { 
       int news_id = Convert.ToInt32(Request.QueryString["id"]);
       int next_news = news_id + 1;
       int ngram_type = Convert.ToInt32(Request.QueryString["ngram_type"]);
       if (ngram_type == 1)
           Response.Redirect("/ner/Ngram?id=" + next_news + "&ngram_type=" + 1);
       else if (ngram_type == 2)
           Response.Redirect("/ner/Ngram?id=" + next_news + "&ngram_type=" + 2);
       else if (ngram_type == 3)
           Response.Redirect("/ner/Ngram?id=" + next_news + "&ngram_type=" + 3);
       else
           Response.Redirect("/ner/Ngram?id=" + next_news + "&ngram_type=" + 4);
    }
  }  
}