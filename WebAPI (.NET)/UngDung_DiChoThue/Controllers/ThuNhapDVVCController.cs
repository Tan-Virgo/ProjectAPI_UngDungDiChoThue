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
    public class ThuNhapDVVCController : ApiController
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        // Doanh thu DVVC theo các năm
        //GET api/ThuNhapDVVC/[MaDVVC]
        [Route("api/ThuNhapDVVC/{MaDVVC}")]
        public HttpResponseMessage Get(int MaDVVC)
        {
            string query = @"
                        SELECT V.Nam, v.TenDVVC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE V.MaDVVC = '" + MaDVVC + " ' " +
                        "GROUP BY V.Nam, V.MaDVVC, v.TenDVVC";
            return GetData(query);
        }

        // Doanh thu DVVC của các quý trong năm
        //GET api/ThuNhapDVVC/[MaDVVC]/[year]
        [Route("api/ThuNhapDVVC/{MaDVVC}/{year}")]
        public HttpResponseMessage Get(int MaDVVC, int year)
        {
            string query = @"
                        SELECT V.Quy, v.TenDVVC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE V.MaDVVC = '" + MaDVVC + "' AND V.Nam = '" + year + "' " +
                        "GROUP BY V.Quy, V.MaDVVC, v.TenDVVC";
            return GetData(query);
        }

        // Doanh thu DVVC của các tháng trong quý trong năm
        //GET api/ThuNhapDVVC/[MaDVVC]/[year]/[quarter]
        [Route("api/ThuNhapDVVC/{MaDVVC}/{year}/{quarter}")]
        public HttpResponseMessage Get(int MaDVVC, int year, int quarter)
        {
            string query = @"
                        SELECT V.Thang, V.TenDVVC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE V.MaDVVC = '" + MaDVVC + "' AND V.Nam = '" + year + "' " +
                        " AND V.Quy = '" + quarter + "' " +
                        "GROUP BY V.Thang, V.MaDVVC, v.TenDVVC";
            return GetData(query);
        }

        // Doanh thu DVVC của các tháng trong quý trong năm
        //GET api/ThuNhapDVVC/[MaDVVC]/[year]/[quarter]/[month]
        [Route("api/ThuNhapDVVC/{MaDVVC}/{year}/{quarter}/{month}")]
        public HttpResponseMessage Get(int MaDVVC, int year, int quarter, int month)
        {
            string query = @"
                        SELECT V.Thang, V.TenDVVC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE V.MaDVVC = '" + MaDVVC + "' AND V.Nam = '" + year + "' " +
                        " AND V.Quy = '" + quarter + "' AND V.Thang = '" + month + "' " +
                        "GROUP BY V.Thang, V.MaDVVC, v.TenDVVC";
            return GetData(query);
        }

        public HttpResponseMessage GetData(string query)
        {
            SqlDataAdapter da = new SqlDataAdapter(query, con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            return Request.CreateResponse(HttpStatusCode.OK, dt);
        }
    }
}
