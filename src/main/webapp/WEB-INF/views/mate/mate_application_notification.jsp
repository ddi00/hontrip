<%--
  Created by IntelliJ IDEA.
  User: ehska
  Date: 2023-08-21
  Time: 오전 10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%@ page import="com.multi.hontrip.mate.dto.Gender" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% long userId = (long) session.getAttribute("id");
    if (userId > 0) {
        request.setAttribute("userId", userId);
    }
%>

<script>

    let userId =
    ${userId}
    const eventSource = new EventSource("/sse" + "?userId=" + userId);

    eventSource.addEventListener('sse', event => {
        console.log(event);
    });
</script>
<div class="content-wrapper">
    <section class="wrapper bg-xs-none">
        <div class="container pt-2 pb-10 pt-md-10 pb-md-10">
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
    <!-- /section -->
    <section class="wrapper bg-xs-none">
        <div class="container pb-14 pb-md-16">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="blog single mt-n15">
                        <div class="card shadow-xl">
                            <div class="card-body">
                                <div class="total">

                                </div>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.blog -->
                </div>
                <!-- /column -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
    <!-- /section -->
</div>
<!-- /.content-wrapper -->

