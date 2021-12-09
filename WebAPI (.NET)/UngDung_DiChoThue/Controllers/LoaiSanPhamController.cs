using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace UngDung_DiChoThue.Controllers
{
    public class LoaiSanPhamController : ApiController
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        //GET api/LoaiSanPham
        public HttpResponseMessage Get()
        {
            string query = @"SELECT * FROM LoaiSanPham";
            SqlDataAdapter da = new SqlDataAdapter(query, con);

            DataTable dt = new DataTable();
            da.Fill(dt);


            return Request.CreateResponse(HttpStatusCode.OK, dt);
        }
    }
}
