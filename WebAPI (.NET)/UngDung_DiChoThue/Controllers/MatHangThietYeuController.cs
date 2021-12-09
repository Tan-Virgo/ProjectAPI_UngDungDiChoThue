using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Web.Http.Results;


namespace UngDung_DiChoThue.Controllers
{
    public class MatHangThietYeuController : ApiController
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        //GET api/MatHangThietYeu
        public HttpResponseMessage Get()
        {
            string query = @"SELECT * FROM V_ThongKe_MatHangThietYeu";
            SqlDataAdapter da = new SqlDataAdapter(query, con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            return Request.CreateResponse(HttpStatusCode.OK, dt);

        }


        //GET api/MatHangThietYeu/[MaLoaiSP]
        [Route("api/MatHangThietYeu/{MaLoaiSP}")]
        public HttpResponseMessage Get(int MaLoaiSP)
        {
            string query = @"SELECT * FROM V_ThongKe_MatHangThietYeu WHERE MaLoaiSP = '" + MaLoaiSP + "'";
            
            SqlDataAdapter da = new SqlDataAdapter(query, con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            return Request.CreateResponse(HttpStatusCode.OK, dt);

        }


    }
}
