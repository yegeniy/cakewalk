function remove_fields (link) {
    alert('about to remove')
    $(link).previous("input[type=hidden]").value = "1";
    alert('got to $(link).up(\".fields\").hide();')
    $(link).up(".fields").hide();


}