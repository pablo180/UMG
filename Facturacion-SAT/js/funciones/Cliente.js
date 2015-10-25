jQuery(document).ready(function () {
    $(".TablaClientes").dataTable();
    MostrarClientes(0);
    var IndexTr;
    $("#BtnNuevoCliente").click(function () {
        $("input:text").val("");
        $("#textMDId").val("");
        $('select').val(0).trigger("chosen:updated");
        $('.ModalEditarVehiculo').modal('toggle');
        $("#BtnGuardarV").show();
        $("#BtnEditarV").hide();
        $("#LblModificar").hide();
        $("#LblCrear").show();
    });
    $(".TablaClientes tbody").on("click", ".BtnEditarCliente", function () {
        //            IndexTr = $(this).parent().parent().index();
        //            $(".TableVehiculos").dataTable().fnDeleteRow(IndexTr);
        $("#BtnEditarV").show();
        $("#BtnGuardarV").hide();
        $("#LblModificar").show();
        $("#LblCrear").hide();
        var id = this.id;
 
        //$("#CheckPool div").removeClass("active");
        $.ajax({
            type: "POST",
            url: "wsCliente.asmx/CatalogoClientes",
            data: "{ 'IdCliente': " + id + " }",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                $.each(data.d, function (index, item) {
                    $("#textMDId").val(item.codigo);
                    // $("#textMDPool").val(item.poolv);
                    $("#textMDCodigo").val(item.codigo);
                    $("#textMDNombre").val(item.Nombre);
                    $("#txtMDNit").val(item.Nit);
                    $("#txtMDTelefono").val(item.Telefono);
                    $("#txtMDDireccion").val(item.Direccion);
                    $("#txtCorreo").val(item.Correo);
                    $("#txtCelular").val(item.Celular);
                  
                    $('#DropEstatus').val(item.IdEstado).trigger("chosen:updated");
                    $('#TxtCOEncargado').val(item.Correo).trigger("chosen:updated");
                    if (item.IdEstado) {
                        $('#DropEstatus').val(1).trigger("chosen:updated");
                    } else {
                        $('#DropEstatus').val(0).trigger("chosen:updated");
                    }
                 
                });
                $('.ModalEditarVehiculo').modal('toggle');
            },
            error: function (data) {
                console.log(data);
            }
        });
    });
});
function MostrarClientes(id) {
    $.ajax({
        type: "POST",
        url: "wsCliente.asmx/CatalogoClientes",
        data: "{ 'IdCliente': " + id + " }",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $.each(data.d, function (index, item) {
                $(".TablaClientes").dataTable().fnAddData([
                    item.codigo,
                    item.Nombre,
                    item.Nit,
                    item.Telefono,
                    item.Celular,
                    item.Direccion,
                    item.Correo,
                    item.Estado,
                    "<button type='button' id='" + item.codigo + "' class='btn btn-default btn-xs BtnEditarCliente'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarCliente'></i> Editar</button>"
                ]);
            });
        },
        error: function (data) {
            console.log(data);
        }
    });
}

$(document).ready(function () {
    $("#BtnEditarV").click(function () {
        var tipo = $("#DropTipoVehiculo").val();
        var departamento = $("#DropDepartamento").val();
        var usuario = $("#DropUsuario").val();
        var status = false;
        if ($("#DropEstatus").val() == 1) {
            status = true;
        }
        var pool = false;
        if ($("#CheckPool div:eq(0)").hasClass("active")) {
            pool = true;
        }
        $.ajax({
            type: "POST",
            url: "WebService.asmx/ActualizarVehiculo",
            data: "{'Id':" + $("#textMDId").val() + ",'codigo':'" + $("#textMDCodigo").val() + "', 'placa':'" + $("#textMDPlaca").val() + "', 'kma':'" + $("#txtMDKilometraje").val() + "', 'marca':'" + $("#txtMDMarca").val() + "', 'linea':'" + $("#txtMDLinea").val() + "', 'modelo':'" + $("#txtMDModelo").val() + "', 'tipo':'" + tipo + "', 'departamento':'" + departamento + "', 'contable':'" + $("#txtMDContable").val() + "', 'status':" + status + ", 'cllantas':" + $("#txtMDCllantas").val() + ", 'repuesto':" + $("#txtMDCllantasR").val() + ", 'pool':" + pool + ", 'Usuario':'" + usuario + "', 'CorreoEncargado':'" + $("#TxtCOEncargado").val() + "'}",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d[0].StrError == "0") {
                    $(".TablaVehiculos").dataTable().fnClearTable();
                    MostrarVehiculos(0);
                    $("input:text, input:hidden").val("");
                    jQuery.gritter.add({
                        title: 'Exito!',
                        text: 'La Operacion Se Ha Realizado Correctamente.',
                        class_name: 'growl-info',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                    $('.ModalEditarVehiculo').modal('toggle');
                } else {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.d[0].StrError,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
            },
            error: function (data) {
                jQuery.gritter.add({
                    title: 'Se Ha Producido Un Error!',
                    text: data.responseText,
                    class_name: 'growl-danger',
                    image: 'images/screen.png',
                    sticky: false,
                    time: ''
                });
            }
        });
    });

});
$(document).ready(function () {
    $("#BtnGuardarV").click(function () {
        var tipo = $("#DropTipoVehiculo").val();
        var departamento = $("#DropDepartamento").val();
        var status = false;
        if ($("#DropEstatus").val() == 1) {
            status = true;
        }
        var pool = false;
        if ($("#CheckPool div:eq(0)").hasClass("active")) {
            pool = true;
        }
        $.ajax({
            type: "POST",
            url: "WebService.asmx/GuardarVehiculo",
            data: "{'codigo':'" + $("#textMDCodigo").val() + "', 'placa':'" + $("#textMDPlaca").val() + "', 'kma':'" + $("#txtMDKilometraje").val() + "', 'marca':'" + $("#txtMDMarca").val() + "', 'linea':'" + $("#txtMDLinea").val() + "', 'modelo':'" + $("#txtMDModelo").val() + "', 'tipo':'" + tipo + "', 'departamento':'" + departamento + "', 'contable':'" + $("#txtMDContable").val() + "', 'status':" + status + ", 'cllantas':" + $("#txtMDCllantas").val() + ", 'repuesto':" + $("#txtMDCllantasR").val() + ", 'pool':" + pool + "}",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                var NuevoId = data.d[0].IdVehiculo;
                if (data.d[0].StrError == "0") {
                    $("input:text, #textMDId").val("");
                    jQuery.gritter.add({
                        title: 'Exito!',
                        text: 'La Operacion Se Ha Realizado Correctamente.',
                        class_name: 'growl-info',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                    $.ajax({
                        type: "POST",
                        url: "WebService.asmx/CatalogoVehiculos",
                        data: "{ 'IdVehiculo': " + NuevoId + " }",
                        dataType: 'json',
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            $.each(data.d, function (index, item) {
                                $(".TablaVehiculos").dataTable().fnAddData([
                                    item.codigo,
                                    item.placa,
                                    item.kma,
                                    item.marca,
                                    item.linea,
                                    item.modelo,
                                    item.tipo,
                                    item.departamento,
                                    "<button type='button' id='" + item.Id + "' class='btn btn-default btn-xs BtnEditarVehiculo'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarVehiculo'></i> Editar</button>"
                                ]);
                            });
                        }
                    });
                    $('.ModalEditarVehiculo').modal('toggle');
                } else {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.d[0].StrError,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
            },
            error: function (data) {
                jQuery.gritter.add({
                    title: 'Se Ha Producido Un Error!',
                    text: data.responseText,
                    class_name: 'growl-danger',
                    image: 'images/screen.png',
                    sticky: false,
                    time: ''
                });
            }
        });
    });

}); //JQuery
