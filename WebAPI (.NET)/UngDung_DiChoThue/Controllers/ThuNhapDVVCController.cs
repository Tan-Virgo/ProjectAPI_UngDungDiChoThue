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

        // Doanh thu DVVC theo các năm hoặc quý hoặc tháng
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


        //GET api/ThuNhapDVVC/[MaDVVC]/[type]/[value]
        [Route("api/ThuNhapDVVC/{MaDVVC}/{type}/{value}")]
        public HttpResponseMessage Get(int MaDVVC, string type, int value)
        {
            string query = @"";

            // Doanh thu tất cả các quý trong năm
            if (type == "ChooseYearAllQuarter")
            {
                query = @"
                        SELECT V.Quy, v.TenDVVC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE V.MaDVVC = '" + MaDVVC + "' AND V.Nam = '" + value + "' " +
                        "GROUP BY V.Quy, V.MaDVVC, v.TenDVVC";
            }
            // Doanh thu tất cả các tháng trong năm
            else if (type == "ChooseYearAllMonth")
            {
                query = @"
                        SELECT V.Thang, v.TenDVVC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE V.MaDVVC = '" + MaDVVC + "' AND V.Nam = '" + value + "' " +
                        "GROUP BY V.Thang, V.MaDVVC, v.TenDVVC";
            }
            // Doanh thu tất cả các năm theo quý
            else if (type == "ChooseQuarterAllYear")
            {
                query = @"
                        SELECT V.Nam, v.TenDVVC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE V.MaDVVC = '" + MaDVVC + "' AND V.Quy = '" + value + "' " +
                        "GROUP BY V.Nam, V.MaDVVC, v.TenDVVC";
            }
            // Doanh thu tất cả các năm theo tháng
            else if (type == "ChooseMonthAllYear")
            {
                query = @"
                        SELECT V.Nam, v.TenDVVC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE V.MaDVVC = '" + MaDVVC + "' AND V.Thang = '" + value + "' " +
                     "GROUP BY V.Nam, V.MaDVVC, v.TenDVVC";
            }
            else
                query = "";


            return GetData(query);
        }


        [Route("api/ThuNhapDVVC_Year")]
        public HttpResponseMessage Get()
        {
            string query = @"
                        SELECT DISTINCT V.Nam
                        FROM V_ThongKe_ThuNhap_DVVC V";
            return GetData(query);
        }

        [Route("api/ThuNhapDVVC/{type}/{MaDVVC}")]
        public HttpResponseMessage Get(string type, int MaDVVC)
        {
            string query = @"
                        SELECT DISTINCT V.Thang, SUM(V.DoanhThu) as 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_DVVC V
                        WHERE MaDVVC = '" + MaDVVC + "' AND V.Nam = YEAR(GETDATE()) " +
                        "GROUP BY V.Thang ORDER BY V.Thang" ;
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
