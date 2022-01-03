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
    public class ThuNhapNCCController : ApiController
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        // Doanh thu NCC theo các năm hoặc quý hoặc tháng
        //GET api/ThuNhapNCC/[MaNCC]
        [Route("api/ThuNhapNCC/{MaNCC}")]
        public HttpResponseMessage Get(int MaNCC)
        {
            string query = @"
                        SELECT V.Nam, v.TenNCC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE V.MaNCC = '" + MaNCC + " ' " +
                        "GROUP BY V.Nam, V.MaNCC, v.TenNCC";
            return GetData(query);
        }


        //GET api/ThuNhapNCC/[MaNCC]/[type]/[value]
        [Route("api/ThuNhapNCC/{MaNCC}/{type}/{value}")]
        public HttpResponseMessage Get(int MaNCC, string type, int value)
        {
            string query = @"";

            // Doanh thu tất cả các quý trong năm
            if (type == "ChooseYearAllQuarter")
            {
                query = @"
                        SELECT V.Quy, v.TenNCC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE V.MaNCC = '" + MaNCC + "' AND V.Nam = '" + value + "' " +
                        "GROUP BY V.Quy, V.MaNCC, v.TenNCC";
            }
            // Doanh thu tất cả các tháng trong năm
            else if (type == "ChooseYearAllMonth")
            {
                query = @"
                        SELECT V.Thang, v.TenNCC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE V.MaNCC = '" + MaNCC + "' AND V.Nam = '" + value + "' " +
                        "GROUP BY V.Thang, V.MaNCC, v.TenNCC";
            }
            // Doanh thu tất cả các năm theo quý
            else if (type == "ChooseQuarterAllYear")
            {
                query = @"
                        SELECT V.Nam, v.TenNCC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE V.MaNCC = '" + MaNCC + "' AND V.Quy = '" + value + "' " +
                        "GROUP BY V.Nam, V.MaNCC, v.TenNCC";
            }
            // Doanh thu tất cả các năm theo tháng
            else if (type == "ChooseMonthAllYear")
            {
                query = @"
                        SELECT V.Nam, v.TenNCC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE V.MaNCC = '" + MaNCC + "' AND V.Thang = '" + value + "' " +
                     "GROUP BY V.Nam, V.MaNCC, v.TenNCC";
            }
            else
                query = "";
            

            return GetData(query);
        }


        [Route("api/ThuNhapNCC_Year")]
        public HttpResponseMessage Get()
        {
            string query = @"
                        SELECT DISTINCT V.Nam
                        FROM V_ThongKe_ThuNhap_NCC V";
            return GetData(query);
        }

        [Route("api/ThuNhapNCC/{type}/{MaNCC}")]
        public HttpResponseMessage Get(string type, int MaNCC)
        {
            string query = @"
                        SELECT DISTINCT V.Thang, SUM(V.DoanhThu) as 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE MaNCC = '" + MaNCC + "' AND V.Nam = YEAR(GETDATE()) " +
                        "GROUP BY V.Thang ORDER BY V.Thang";
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
