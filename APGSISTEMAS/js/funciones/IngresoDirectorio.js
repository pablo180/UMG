$(document).ready(function () {
    LlenarDepartamentos();

});

function LlenarDepartamentos() {
    $.ajax({
        type: "POST",
        url: "wsdepartamentomunicipio.asmx/Departamentos",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            $.each(msg.d, function (index, item) {
                $("#DropDepartamento").trigger('chosen:updated').append("<option value='" + item.IdDepartamento + "'>" + item.Nombre + "</option>");
            });
            //$("#DropDepartamento, #DropDepartamento3, #DropDepartamentoOrigen4, #DropDepartamentoDestino4").select2().select2("val");
            LlenarMunicipio($("#DropDepartamento").val());
        },
        error: function (msg) {
            Error(msg.responseText);
        }
    });
    jQuery("select").chosen({ 'width': '100%', 'white-space': 'nowrap' });
}

function LlenarMunicipio(IdDepartamento) {
    $.ajax({
        type: "POST",
        url: "wsdepartamentomunicipio.asmx/Municipios",
        contentType: "application/json; charset=utf-8",
        data: "{IdDepartamento:" + IdDepartamento + "}",
        dataType: "json",
        success: function (msg) {
            $("#DropMunicipios").html("");
            $.each(msg.d, function (index, item) {
                $("#DropMunicipios").trigger('chosen:updated').append("<option value='" + item.IdMunicipio + "'>" + item.Nombre + "</option>");
            });
            //$("#DropMunicipios").select2().select2("val");
        },
        error: function (msg) {
            msgerror(msg.responseText);
        }
    });
}

$("#DropDepartamento").bind("change blur", function () {
    LlenarMunicipio($(this).val());
});