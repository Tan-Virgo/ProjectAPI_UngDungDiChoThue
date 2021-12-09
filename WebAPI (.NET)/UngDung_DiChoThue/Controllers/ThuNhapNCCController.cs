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

        // Doanh thu NCC theo các năm
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

        // Doanh thu NCC của các quý trong năm
        //GET api/ThuNhapNCC/[MaNCC]/[year]
        [Route("api/ThuNhapNCC/{MaNCC}/{year}")]
        public HttpResponseMessage Get(int MaNCC, int year)
        {
            string query = @"
                        SELECT V.Quy, v.TenNCC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE V.MaNCC = '" + MaNCC + "' AND V.Nam = '" + year + "' " +
                        "GROUP BY V.Quy, V.MaNCC, v.TenNCC";
            return GetData(query);
        }

        // Doanh thu NCC của các tháng trong quý trong năm
        //GET api/ThuNhapNCC/[MaNCC]/[year]/[quarter]
        [Route("api/ThuNhapNCC/{MaNCC}/{year}/{quarter}")]
        public HttpResponseMessage Get(int MaNCC, int year, int quarter)
        {
            string query = @"
                        SELECT V.Thang, V.TenNCC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE V.MaNCC = '" + MaNCC + "' AND V.Nam = '" + year + "' " +
                        " AND V.Quy = '" + quarter + "' " +
                        "GROUP BY V.Thang, V.MaNCC, v.TenNCC";
            return GetData(query);
        }

        // Doanh thu NCC của các tháng trong quý trong năm
        //GET api/ThuNhapNCC/[MaNCC]/[year]/[quarter]/[month]
        [Route("api/ThuNhapNCC/{MaNCC}/{year}/{quarter}/{month}")]
        public HttpResponseMessage Get(int MaNCC, int year, int quarter, int month)
        {
            string query = @"
                        SELECT V.Thang, V.TenNCC, SUM(V.DoanhThu) AS 'TongDoanhThu'
                        FROM V_ThongKe_ThuNhap_NCC V
                        WHERE V.MaNCC = '" + MaNCC + "' AND V.Nam = '" + year + "' " +
                        " AND V.Quy = '" + quarter + "' AND V.Thang = '" + month + "' " + 
                        "GROUP BY V.Thang, V.MaNCC, v.TenNCC";
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
