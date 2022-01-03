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
using System.Windows;

namespace UngDung_DiChoThue.Controllers
{
    public class MatHangThietYeuController : ApiController
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        // DANH SÁCH THỐNG KÊ TẤT CẢ CÁC MẶT HÀNG
        //GET api/MatHangThietYeu
        public HttpResponseMessage Get()
        {
            string query = @"SELECT * FROM V_ThongKe_MatHangThietYeu";

            return GetData(query);

        }

        // DANH SÁCH THỐNG KÊ THEO MỘT ĐIỀU KIỆN LỌC
        //GET api/MatHangThietYeu/[type]/[values]
        //[Route("api/MatHangThietYeu/{type}/{values}")]
        //public HttpResponseMessage Get(string type, int values)
        //{
        //    string query = "";
        //    if (type == "LoaiSanPham")
        //    {
        //        query = @"SELECT * FROM V_ThongKe_MatHangThietYeu WHERE MaLoaiSP = '" + values + "'";
        //    }
        //    else if (type == "SanPham")
        //    {
        //        query = @"SELECT * FROM V_ThongKe_MatHangThietYeu WHERE MaSP = '" + values + "'";
        //    }
        //    else if (type == "NhaCungCap")
        //    {
        //        query = @"SELECT * FROM V_ThongKe_MatHangThietYeu WHERE MaNCC = '" + values + "'";
        //    }
              
        //    return GetData(query);

        //}

        // DANH SÁCH THỐNG KÊ THEO 2 ĐIỀU KIỆN LỌC
        //GET api/MatHangThietYeuOption/[type]/[value1]/[value2]
        //[Route("api/MatHangThietYeuOption/{type}/{value1}/{value2}")]
        //public HttpResponseMessage Get(string type, int value1, int value2)
        //{
        //    string query = "";
            
        //    if (type == "LoaiSanPham_SanPham")
        //    {
        //        query = @"SELECT * FROM V_ThongKe_MatHangThietYeu WHERE MaLoaiSP = '" + value1 + "' AND MaSP = '" + value2 + "'";
        //    }
        //    else if (type == "LoaiSanPham_NhaCungCap")
        //    {
        //        query = @"SELECT * FROM V_ThongKe_MatHangThietYeu WHERE MaLoaiSP = '" + value1 + "' AND MaNCC = '" + value2 + "'";
        //    }
        //    else if (type == "SanPham_NhaCungCap")
        //    {
        //        query = @"SELECT * FROM V_ThongKe_MatHangThietYeu WHERE MaSP = '" + value1 + "' AND MaNCC = '" + value2 + "'";
        //    }
           

        //    return GetData(query);

        //}

        // DANH SÁCH THỐNG KÊ THEO CẢ 3 ĐIỀU KIỆM LỌC
        //GET api/MatHangThietYeuAllOption/[MaLoaiSP]/[MaSP]/[MaNCC]
        //[Route("api/MatHangThietYeu/{MaLoaiSP}/{MaSP}/{MaNCC}")]
        //public HttpResponseMessage Get(int MaLoaiSP, int MaSP, int MaNCC)
        //{
        //    string query = @"SELECT * FROM V_ThongKe_MatHangThietYeu WHERE MaLoaiSP = '" + MaLoaiSP + "' AND MaSP = '" + MaSP + "' AND MaNCC = '" + MaNCC + "'";

        //    return GetData(query);

        //}


        public HttpResponseMessage GetData(string query)
        {
            SqlDataAdapter da = new SqlDataAdapter(query, con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            return Request.CreateResponse(HttpStatusCode.OK, dt);
        }
    }
}
