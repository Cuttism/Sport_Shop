package controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String userMessage = request.getParameter("message");
        if (userMessage == null) userMessage = "";
        userMessage = userMessage.toLowerCase();

        String reply = getReplyForMessage(userMessage);

        String jsonResponse = "{\"reply\": \"" + reply.replace("\"", "\\\"").replace("\n", "\\n") + "\"}";

        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }

    private String getReplyForMessage(String msg) {
        if (msg.contains("xin chào") || msg.contains("hello") || msg.contains("hi")) {
            return "Chào bạn! Mình là trợ lý ảo của SportShop. Mình có thể giúp gì cho bạn hôm nay?";
        } else if (msg.contains("giá") || msg.contains("bao nhiêu tiền")) {
            return "Giá sản phẩm được hiển thị công khai trên website. Bạn có thể bấm vào sản phẩm để xem chi tiết nhé!";
        } else if (msg.contains("giao hàng") || msg.contains("ship") || msg.contains("vận chuyển")) {
            return "SportShop hỗ trợ giao hàng toàn quốc. Thời gian giao hàng từ 2-5 ngày làm việc tùy khu vực.";
        } else if (msg.contains("địa chỉ") || msg.contains("cửa hàng ở đâu")) {
            return "SportShop hiện chỉ bán trực tuyến. Các kho hàng của chúng tôi đặt tại TP. HCM và Hà Nội để tối ưu vận chuyển.";
        } else if (msg.contains("thanh toán")) {
            return "Bạn có thể thanh toán bằng Tiền mặt (COD), Thẻ Visa/Mastercard hoặc Ví điện tử MoMo khi đặt hàng.";
        } else if (msg.contains("đổi trả") || msg.contains("bảo hành")) {
            return "Sản phẩm được bảo hành 1 đổi 1 trong 7 ngày nếu lỗi từ nhà sản xuất. Hãy giữ nguyên tem mác nhé!";
        } else {
            return "Xin lỗi, mình chưa hiểu ý bạn. Bạn có thể mô tả rõ hơn, hoặc để lại số điện thoại để nhân viên tư vấn gọi điện lại cho bạn nhé!";
        }
    }
}
