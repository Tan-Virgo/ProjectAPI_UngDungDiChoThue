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
    public class NhuCauThucPhamCungKyController : ApiController
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        //GET api/NhuCauThucPhamCungKy/[MaSP]/[MaNCC]/[type]/[value]
        [Route("api/NhuCauThucPhamCungKy/{MaSP}/{MaNCC}/{type}/{value}")]
        public HttpResponseMessage Get(int MaSP, int MaNCC, string type, int value)
        {
            if (MaNCC == 0) // Không lọc theo NCC
            {
                if (type == "ChooseYearAllQuarter")
                {
                    string query = @"
                        SELECT V.Quy, V.TenSP, V.DonViTinh, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP+ "' " +
                        "GROUP BY V.Quy, V.TenSP, V.DonViTinh";
                    return GetData(query);
                }
                else if (type == "ChooseYearAllMonth")
                {
                    string query = @"
                        SELECT V.Thang, V.TenSP, V.DonViTinh, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP + "' " +
                        "GROUP BY V.Thang, V.TenSP, V.DonViTinh";
                    return GetData(query);
                }
                else if (type == "ChooseQuarterAllYear")
                {
                    string query = @"
                        SELECT V.Nam, V.TenSP, V.DonViTinh, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Quy = '" + value + "' AND V.MaSP = '" + MaSP + "' " +
                        "GROUP BY V.Nam, V.TenSP, V.DonViTinh";
                    return GetData(query);
                }
                else // ChooseMonthAllYear
                {
                    string query = @"
                        SELECT V.Nam, V.TenSP, V.DonViTinh, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Thang = '" + value + "' AND V.MaSP = '" + MaSP + "' " +
                        "GROUP BY V.Nam, V.TenSP, V.DonViTinh";
                    return GetData(query);
                }    
            }
            else //  lọc thêm NCC
            {
                if (type == "ChooseYearAllQuarter")
                {
                    string query = @"
                        SELECT V.Quy, V.TenSP, V.DonViTinh, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                        "GROUP BY V.Quy, V.TenSP, V.DonViTinh";
                    return GetData(query);
                }
                else if (type == "ChooseYearAllMonth")
                {
                    string query = @"
                        SELECT V.Thang, V.TenSP, V.DonViTinh, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                        "GROUP BY V.Thang, V.TenSP, V.DonViTinh";
                    return GetData(query);
                }
                else if (type == "ChooseQuarterAllYear")
                {
                    string query = @"
                        SELECT V.Nam, V.TenSP, V.DonViTinh, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Quy = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                        "GROUP BY V.Nam, V.TenSP, V.DonViTinh";
                    return GetData(query);
                }
                else // ChooseMonthAllYear
                {
                    string query = @"
                        SELECT V.Nam, V.TenSP, V.DonViTinh, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Thang = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                        "GROUP BY V.Nam, V.TenSP, V.DonViTinh";
                    return GetData(query);
                }
            }
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
