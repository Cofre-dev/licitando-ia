
<!DOCTYPE html>
<html lang="es">
<head>
    <!-- Hotjar Tracking Code for mercadopublico.cl -->
    <script>
        (function (h, o, t, j, a, r) {
            h.hj = h.hj || function () { (h.hj.q = h.hj.q || []).push(arguments) };
            h._hjSettings = { hjid: 3250843, hjsv: 6 };
            a = o.getElementsByTagName('head')[0];
            r = o.createElement('script'); r.async = 1;
            r.src = t + h._hjSettings.hjid + j + h._hjSettings.hjsv;
            a.appendChild(r);
        })(window, document, 'https://static.hotjar.com/c/hotjar-', '.js?sv=');
    </script>

    <!-- Integracion con SSO -->
        <script type="text/javascript" src="/Home/keycloak.min.js?v=25.0.6"></script>
        <script type="text/javascript" src="/Home/Scripts/sweetalert2.min.js"></script>
        <script type="text/javascript">
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 5000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        })

        var keycloak = new Keycloak('https://www.mercadopublico.cl/Home/keycloak/keycloakProd.json');
    function initKeycloak() {
        var initOptions = {
                responseMode: 'fragment',
                flow: 'hybrid',
                Onload: 'login-required'
            };
    keycloak.init(initOptions).then(function (authenticated) {
        if (keycloak.authenticated == true) {
                    SSO()
                    keycloak.clearToken();
                }
    }).catch(function () {
        alert('Error al iniciar sesión, por favor intenta nuevamente.');
    });
    }
        </script>
        <!-- Google Tag Manager -->
        <script>
            (function (w, d, s, l, i) {
                w[l] = w[l] || []; w[l].push({
                    'gtm.start':
                        new Date().getTime(), event: 'gtm.js'
                }); var f = d.getElementsByTagName(s)[0],
                    j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : ''; j.async = true; j.src =
                        'https://www.googletagmanager.com/gtm.js?id=' + i + dl; f.parentNode.insertBefore(j, f);
            })(window, document, 'script', 'dataLayer', 'GTM-WLFTMTX');
        </script>
        <!-- End Google Tag Manager -->

        <title>
            Mercado Público - La plataforma de compras públicas y oportunidades de negocio
            del Estado de Chile
        </title>
        <meta charset="utf-8">
        <meta name="MobileOptimized" content="320">
        <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="Language" content="es" />
        <meta name="robots" content="index,follow" />
        <meta http-equiv="refresh" content="1140">
        <link href="/Home/favicon.ico" rel="shortcut icon" type="image/x-icon" />
        <link href="/Home/Content/bootstrap.css" rel="stylesheet"/>

        <link rel="stylesheet" type="text/css" href="/Home/Content/bootstrap-3.4.1/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Content/jquery.autocomplete.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Content/token-input.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Scripts/datepicker/css/datepicker.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Content/Terminos/css/Glosario.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Css/chat.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Content/sweetalert2.min.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Content/NuevaHomeFreeCache.css?v=202506171256" />
        <link rel="stylesheet" type="text/css" href="/Home/Content/ModalAlertas/UsuarioBloqueadoInactivo.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Content/NuevaHome.css" />
        <link rel="stylesheet" type="text/css" href="/Home/Content/BloqueoEspecial.css?v=202506171256" />
        <!--Estilos para el icono de chat personalizado, tooltip y superposición de carga */-->
            <link rel="stylesheet" type="text/css" href="https://cfg-bot-ui.mercadopublico.cl/widget-styles.css" />
        <link href="/Home/Content/MercadoPublico.css" rel="stylesheet"/>


        <link href="/Home/Scripts/smartmenus-0.9.7/addons/bootstrap/jquery.smartmenus.bootstrap.css" rel="stylesheet"/>

        <script src="/Home/Scripts/Home/Seguimiento.js" type="text/javascript"></script>
        <script type="text/javascript" src="/Home/Scripts/jquery-3.4.1.min.js"></script>

        <style>
            /*------------------------------------- Cambio de Contraseña*/
            #blanket {
                background-color: #111;
                opacity: 0.65;
                filter: alpha(opacity=65);
                position: absolute;
                z-index: 9001;
                top: 0px;
                left: 0px;
                width: 100%;
            }

            #popUpDiv {
                border-radius: 5px;
                -moz-border-radius: 5px;
                box-shadow: 0px 0px 50px 5px #111;
                position: absolute;
                background-color: #eeeeee;
                width: 440px;
                height: 375px;
                z-index: 9002;
            }

            .cssLabelCC {
                width: 80%;
                margin: 1em;
                padding-top: 2em;
            }

            .cssTextboxCC {
                border: 1px #ccc solid;
                width: 80%;
                margin-left: 1em;
                padding: .4em;
            }

            .pstrength-minchar {
                margin-left: 15px;
            }

            .pstrength-bar {
                margin-left: 13px;
            }

            .pstrength-info {
                margin-left: 13px;
            }
        </style>
        
    </head>
<!-- Google Tag Manager (noscript) -->
<noscript>
    <iframe src="https://www.googletagmanager.com/ns.html?id=GTM-WLFTMTX" height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>
<!-- End Google Tag Manager (noscript) -->

    <div id="ccBarraOpciones"></div>

<header class="container no-print" role="banner" id="encabezado">
    <nav class="row">
        <div class="col-md-3">
            <a href="http://www.mercadopublico.cl/Home/" class="logo header" target="_self">
                <img src="/Home/Imagenes/NuevoHome/logo-chilecompra-original.png" alt="Imagen de logotipo de Mercado Público" />
            </a>
        </div>
        <div class="col-md-9 botonera-nav">
            <div class="pull-right botonera-capsula">

                <a href="https://eco.mercadopublico.cl/economia_circular/" target="_blank" class="link secondary-color">Economía Circular</a>

                    <a href="http://www.mercadopublico.cl/TiendaHome/" target="_blank" class="link secondary-color"><svg class="icon icon-guideline-carrito-lineal-thin"><use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-carrito-lineal-thin"></use></svg>Tienda Convenio Marco</a>

                        <a href="#" onclick="pagoSinLogin();" class="link secondary-color">Pago de Acreditación</a>

                    <a href="#" onclick="irCHP();" class="btn btn-xl btn-ghost">Regístrate</a>



                <div class="inline-block inicio-sesion">
                    <!-- Integracion con SSO -->
                    <button class="btn btn-xl btn-pri" value="Iniciar sesión" onclick="keycloak.login()">Iniciar Sesión</button>

                    <div>
                        <a class="center-block text-center no-color-change" href="/Home/RecuperacionContrasena?esNuevaHome=true" target="_blank">&#191;Olvidaste tu contrase&#241;a?</a>
                    </div>
                    <div id="OrganizacionesUsuario"></div>
                </div>
            </div>

            <!-- Tooltip / ventana acceso usuarios -->
            <div style="display: none">
                <div id="content2">
                    <iframe id="login_home" scrolling="no" height="315px" width="364px" frameborder="0" allowtransparency="true"></iframe>
                </div>
            </div>
            <!-- Tooltip / ventana acceso usuarios -->

        </div>
    </nav>
    <script type="text/javascript">
        function SSO() {
            const token = keycloak.token;
            const tokenParsed = keycloak.tokenParsed;
            if (keycloak.authenticated == true) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    async: false,
                    cache: false,
                    url: "/Home/Autenticacion/LoginSSO",
                    data: { Rut: tokenParsed.preferred_username, Tipo: tokenParsed.dijito },
                    success: function (data) {
                        if (!data.ErrorLogin) {
                            if (data.tieneOrganizaciones)
                                ObtenerOrganizacionesSSO(tokenParsed.preferred_username, tokenParsed.dijito, token, data.TipoAcceso);
                        }
                        else {
                            switch (data.MensajeLogin) {
                                case "UnregisteredUser":
                                    Swal.fire({
                                        imageUrl: '/Home/Imagenes/Coloricon.svg',
                                        imageHeight: 48,
                                        title: 'Este RUT no se encuentra registrado en Mercado Público',
                                        text: 'Para ingresar como empresa proveedora, reg\u00edstrate en la plataforma. Si eres parte de un organismo comprador, contacta a qui\u00e9n administra la instituci\u00f3n en Mercado P\u00fablico para que gestione tu acceso',
                                        confirmButtonText: 'Cerrar'
                                    });
                                    keycloak.clearToken();
                                    break
                                case "nocookiespresents":
                                    Swal.fire({
                                        text: 'Esta aplicaci&#243;n requiere el uso de cookies.\n\rActive la opci&#243;n, y vuelva a intentarlo.',
                                        icon: 'info',
                                        confirmButtonText: 'Cerrar'
                                    });
                                    keycloak.clearToken();
                                    break
                                case "default":
                                    Swal.fire("Tu cuenta de usuario presenta un inconveniente, para resolverlo por favor comun\u00EDcate con la Mesa de Ayuda al 600 700 600 o al +56 4 4236 0646");
                            }
                        }
                    },
                    error: function (xhr, status, error) {
                        alert('Ha ocurrido un error. Favor intente nuevamente.');
                        respuesta = false;
                    }
                });
            }
        }

        function ActualizarClave(p_identificacion) {
            $.ajax({
                type: "POST",
                dataType: "html",
                async: false,
                cache: false,
                url: "/Home/Autenticacion/ActualizarClave",
                data: { rut: p_identificacion },
                success: function (data) {
                    $("#OrganizacionesUsuario").html(data);
                    $('#myModal').modal('hide');
                    $('#myModal2').modal('show');
                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.Message);
                }
            });
        }

        function ObtenerOrganizacionesSSO(rut, tipo, token, tipoacceso) {

            $.ajax({
                type: "POST",
                dataType: "html",
                async: false,
                cache: false,
                url: "/Home/Autenticacion/ObtenerOrganizacionesSSO",
                data: { rut: rut, Tipo: tipo, token: token, tipoacceso: tipoacceso },
                success: function (data) {
                    if (!data.ErrorLogin) {
                        $("#OrganizacionesUsuario").html(data);
                        $('#myModal').modal('show');
                    }
                    else {
                        switch (data.MensajeLogin) {
                            case "actualizarclavepororg":
                                Swal.fire('Su usuario no está asociado a ninguna organización, Por favor contactar a la mesa de ayuda al 600 7000 600 o al +56 4 4236 0646');
                                break
                            case "nocookiespresents":
                                Swal.fire({
                                    text: 'Esta aplicaci&#243;n requiere el uso de cookies.\n\rActive la opci&#243;n, y vuelva a intentarlo.',
                                    icon: 'info',
                                    confirmButtonColor: "#768AA2",
                                    confirmButtonText: 'Cerrar'
                                });
                                keycloak.clearToken();
                                break
                            default:
                                Swal.fire("Tu cuenta de usuario presenta un inconveniente, para resolverlo por favor comun\u00EDcate con la Mesa de Ayuda al 600 700 600 o al +56 4 4236 0646");
                        }
                    }
                },
                error: function (xhr, status, error) {
                    alert('Ha ocurrido un error. Favor intente nuevamente.');
                    respuesta = false;
                }
            });
        }

        function SeleccionarPorOrganizacionSSO(p_tipo, RutUsuario, token, TipoAcceso, Nacionalidad) {
            var marcaEmp = false;
            var codigoEmp = 0;
            $(".rdbOrganismo").each(function (index) {
                if ($(this).is(':checked')) {
                    marcaEmp = true;
                    codigoEmp = $(this).val();
                }
            });

            if (!marcaEmp) {
                alert("Debe checkear al menos un organismo");
                return false;
            }

            if (p_tipo == 'login') {
                var url = "/Home/Autenticacion/LoginPorOrganizacionSSO";
                var data = JSON.stringify({ CodigoEmpresa: codigoEmp, Rut: RutUsuario, Token: token, TipoAcceso: TipoAcceso, Nacionalidad: Nacionalidad });
                $.ajax({
                    type: "POST",
                    data: data,
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    cache: false,
                    success: function (data) {
                        if (!data.ErrorLogin) {
                            window.location.href = "../../../../Portal/Modules/Menu/Menu.aspx"
                        }
                        else {
                            switch (data.MensajeLogin) {
                                case "actualizarclavepororg":
                                    Swal.fire('Su usuario no está asociado a ninguna organización, Por favor contactar a la mesa de ayuda al 600 7000 600 o al +56 4 4236 0646');
                                    break
                                case "nocookiespresents":
                                    Swal.fire({
                                        showCloseButton: true,
                                        text: 'Esta aplicaci&#243;n requiere el uso de cookies.\n\rActive la opci&#243;n, y vuelva a intentarlo.',
                                        icon: 'info',
                                        confirmButtonColor: "#768AA2",
                                        confirmButtonText: 'Cerrar'
                                    });
                                    break
                                case "loginAccreditationIsLocked":
                                    Swal.fire({
                                        imageUrl: '/Home/Imagenes/Coloricon.svg',
                                        imageHeight: 48,
                                        showCancelButton: true,
                                        showCloseButton: true,
                                        cancelButtonColor: "#0064FF",
                                        title: 'Tu Certificación de Competencias en Compras Públicas no se encuentra vigente',
                                        html: 'Para continuar, deber\u00e1s ingresar a la plataforma de ' +
                                              '<a href="https://capacitacion.chilecompra.cl/mod/page/view.php?id=18633" > Ir a Capacitaciones </a> ' +
                                              ' de ChileCompra para completar y obtener tu certificaci\u00F3n.',
                                        cancelButtonText: '<a style= "color: white;" href="https://capacitacion.chilecompra.cl/mod/page/view.php?id=18633" > Capacitaciones</a>',
                                        confirmButtonColor: 'Volver a Mercado Público'
                                    });
                                    break
                                case "loginUserIsLocked":
                                    Swal.fire({
                                        imageUrl: '/Home/Imagenes/Coloricon.svg',
                                        imageHeight: 48,
                                        showCloseButton: true,
                                        title: 'Tu cuenta se ha bloqueado temporalmente',
                                        text: 'Has superado el l\u00edmite de intentos fallidos para ingresar a tu cuenta. Por favor, espera 15 minutos y vuelve a intentarlo.',
                                        confirmButtonColor: "#768AA2",
                                        confirmButtonText: 'Aceptar'
                                    });
                                    break
                                case "loginOrgIsActive":
                                    Swal.fire({
                                        imageUrl: '/Home/Imagenes/Coloricon.svg',
                                        imageHeight: 48,
                                        showCloseButton: true,
                                        title: 'La unidad a la que intentas ingresar se encuentra inactiva',
                                        text: 'Consulta a quien administra la instituci\u00F3n en la plataforma para verificar que la unidad a la que intentas ingresar se encuentra en estado activo',
                                        confirmButtonColor: "#768AA2",
                                        confirmButtonText: 'Aceptar'
                                    });
                                    break
                                case "CasoBorde":
                                    Swal.fire({
                                        imageUrl: '/Home/Imagenes/Coloricon.svg',
                                        imageHeight: 48,
                                        showCancelButton: true,
                                        showCloseButton: true,
                                        cancelButtonColor: "#0064FF",
                                        cancelButtonText: '<a style= "color: white;" href="https://ayuda.mercadopublico.cl/" >Ir al Centro de Ayuda</a>',
                                        confirmButtonText: 'Volver a Mercado Público',
                                        title: 'Tu cuenta presenta inconvenientes para ingresar a Mercado Público',
                                        html: 'Comun\u00edcate con nosotros a trav\u00e9s de nuestro ' +
                                        '<a href="https://ayuda.mercadopublico.cl/" > Centro de Ayuda</a> ' +
                                        ' para informarnos del inconveniente que presentas'
                                    });
                                    break
                                case "actualizarclave":
                                    ActualizarClave(RutUsuario);
                                    break
                                case "USRLOCKED_NUEVA_LEY":                                   
                                    $("#myModal").modal('hide');
                                    $("#modalSpecialBlock_title").text(data.TituloModal || '');
                                    $("#modalSpecialBlock_msj").text(data.MensajeModal || '');
                                    $("#modalSpecialBlock").modal();                             
                                    break
                                case "USRLOCKED_GENERAL":
                                    $("#myModal").modal('hide');
                                    $("#modalSpecialBlock_title").text(data.TituloModal || '');
                                    $("#modalSpecialBlock_msj").text(data.MensajeModal || '');
                                    $("#modalSpecialBlock").modal();
                                    break
                                default:
                                    Swal.fire("Tu cuenta de usuario presenta un inconveniente, para resolverlo por favor comun\u00EDcate con la Mesa de Ayuda al 600 700 600 o al +56 4 4236 0646");
                            }
                        }
                    },
                    error: function (xhr, status, error) {
                        alert('Ha ocurrido un error. Favor intente nuevamente.');
                        respuesta = false;
                    }
                });
            }
        }

    </script>
    <script>
        window.onload = SSO;
    </script>
</header>
<body onload="initKeycloak()">
    <!-- Integracion con SSO -->
    <script>
        function loadProfile() {
            keycloak.loadUserProfile().success(function (profile) {
                output(profile);
            }).error(function () {
                output('Failed to load profile');
            });
        }
        function loadUserInfo() {
            keycloak.loadUserInfo().success(function (userInfo) {
                output(userInfo);
            }).error(function () {
                output('Failed to load user info');
            });
        }
        function refreshToken(minValidity) {
            keycloak.updateToken(minValidity).success(function (refreshed) {
                if (refreshed) {
                    output(keycloak.tokenParsed);
                } else {
                    output('Token not refreshed, valid for ' + Math.round(keycloak.tokenParsed.exp + keycloak.timeSkew - new Date().getTime() / 1000) + ' seconds');
                }
            }).error(function () {
                output('Failed to refresh token');
            });
        }
        function showExpires() {
            if (!keycloak.tokenParsed) {
                output("Not authenticated");
                return;
            }
            var o = 'Token Expires:\t\t' + new Date((keycloak.tokenParsed.exp + keycloak.timeSkew) * 1000).toLocaleString() + '\n';
            o += 'Token Expires in:\t' + Math.round(keycloak.tokenParsed.exp + keycloak.timeSkew - new Date().getTime() / 1000) + ' seconds\n';
            if (keycloak.refreshTokenParsed) {
                o += 'Refresh Token Expires:\t' + new Date((keycloak.refreshTokenParsed.exp + keycloak.timeSkew) * 1000).toLocaleString() + '\n';
                o += 'Refresh Expires in:\t' + Math.round(keycloak.refreshTokenParsed.exp + keycloak.timeSkew - new Date().getTime() / 1000) + ' seconds';
            }
            output(o);
        }
    </script>

    <!-- Precarga página -->
    <div id="preloader">
        <div class="logopreload">
            <div id="status">
            </div>
        </div>
    </div>
    <!-- / Precarga página -->
    <a name="linktotop"></a>


    <section id="terminos" class="container" style="display:none;">
        <div class="wrap">
            <div class="glosario">
                <div class="glo-open">
                    <i class="ayuda-ico"></i>
                    <span class="ayuda-glo">
                        Ayuda
                    </span>
                </div>
                <div class="glo-wrap">
                    <h2>
                        No entiendes algo?
                        te explicamos acá
                    </h2>
                    <div class="input-wrapper">
                        <input type="text" name="country" id="autocomplete-ajax" style="position: absolute; z-index: 2;" />
                        <input type="text" name="country" id="autocomplete-ajax-x" disabled="disabled" style="color: #CCC; position: absolute; background: transparent; z-index: 1;" />
                    </div>
                    <div id="selction-ajax" class="definicion"></div>
                </div>

            </div>
        </div>
    </section>
    
<script type="text/javascript" src="//maps.googleapis.com/maps/api/js?key=AIzaSyCraF9HyZKtouO3eAUkF9W8_fkw8DllnbY&sensor=false"></script>

<link href="/Home/Content/Animate.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript">
    if (parent.document.location != document.location) {
        parent.document.location = document.location;
    }
</script>
<!--se agrega css de búsqueda avanzada en el caso del uso de GCA--> 
<input id="hdnRutaBuscador" name="hdnRutaBuscador" type="hidden" value="https://www.mercadopublico.cl" />


<input id="hdnNombreSitioBuscador" name="hdnNombreSitioBuscador" type="hidden" value="BuscarLicitacion" />

<main role="main" id="main" class="ContenidoBarra">

    <section class="container buscador-seccion">
        <div class="col-xs-12 bloque">
            <div id="dvTotalOportunidades" class="row">
                <h1 class="text-center text-light" id="monto-titulo">Encuentra hasta <span class="text-light pri-color">4508</span> oportunidades de negocio en todo Chile</h1>

            </div>
<form action="/Home/BusquedaLicitacion" id="formBusqueda" method="post"><input name="__RequestVerificationToken" type="hidden" value="kasoaIwTFnwTPsO3Hus0wzS9LtltJ1Ec6aGbVTOLIFqB-Ubc2nFBuMHzwbejaI-8WKsD3TBP0TWu8ej7dBhV-E3CsgvfIuKdnq5wIe9KEb6fT6WCK9TMQGtO5h41" />                <div class="row">

                    <div id="qdesign_hidden"></div>
                    <div class="col-md-12 buscador-header">
                        <div class="row col-md-8 col-md-offset-2">
                            <div class="buscador animated-input col-md-12">
                                <div id="label-buscador" class="text-light">¿Qué deseas vender al Estado?</div>
                                <input id="txtBuscar" class="form-control text-light input-mp" />
                                <span class="bar"></span>
                                <button id="btnBuscar" class="btn"><span class="buscar-icono"><svg class="icon icon-guideline-buscador-lineal"><use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-buscador-lineal"></use></svg></span></button>
                                    <a href="#" id="btnExplorar" class="margin-top-xs secondary-color adv-toggle-btn">Explorar todas las licitaciones</a>

                            </div>

                        </div>
                        <div class="row col-md-12 tipo-licitaciones margin-top-lg">
                                <ul class="align-item-center">
                                        <li><a href="https://www.mercadopublico.cl/Portal/Modules/Site/Busquedas/BuscadorAvanzado.aspx?qs=2" target="_blank" class="btn-sm">Órdenes de compra</a></li>
                                                                                                                <li>
											<span style="position: relative; display: inline-flex; vertical-align: middle;">
												<a href="https://buscador.mercadopublico.cl/compra-agil" target="_blank" class="btn-sm">Compra &#193;gil</a>
											</span>
										</li>
                                    <li><a href="https://www.mercadopublico.cl/Contratos/Ciudadania" target="_blank" class="btn-sm">Contratos</a></li>
                                    <li><a href="https://consulta-mercado.mercadopublico.cl/buscador-publico" target="_blank" class="btn-sm">Consultas al mercado</a></li>
                                    <li><a href="https://www.mercadopublico.cl/Portal/Modules/Site/Busquedas/BuscadorAvanzado.aspx?qs=9" target="_blank" class="btn-sm">Grandes compras</a></li>
                                        <li><a href="https://trato-directo.mercadopublico.cl/buscador-publico" target="_blank" class="btn-sm">Trato directo</a></li>
                                                                            <li><a href="#" onclick="irBusquedaProveedor();" class="btn-sm">Proveedores</a></li>
                                                                            <li><a href="https://comprador.mercadopublico.cl/busqueda" target="_blank" class="btn-sm">Compradores</a></li>
                                </ul>

                        </div>
                    </div>
                </div>
</form>        </div>
    </section>
    <section class="filtro-region">
        <div class="light-background"></div>
        <div class="container datos-buscador">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">

                    <div class="dropdown selector-regiones">
                        <button id="selectorRegion" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <div class="text-center">
                                <h4 class="subtitle">Oportunidades de negocio en:</h4>
                            </div>
                            <div class="nombre-region">
                                <h3 class="pri-color">Región Metropolitana de Santiago</h3>
                                <span class="pri-color"><svg class="icon-guideline-flecha-abajo-lineal"><use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-flecha-abajo-lineal"></use></svg></span>
                            </div>
                            <small class="secondary-color text-italic">Información actualizada cada 5 minutos</small>
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dLabel">
                            <ul class="col-md-4">
                                <li><strong>Zona Norte</strong></li>
                                <li><a data-number="15" href="#">Región de Arica y Parinacota</a></li>
                                <li><a data-number="1" href="#">Región de Tarapacá</a></li>
                                <li><a data-number="2" href="#">Región de Antofagasta</a></li>
                                <li><a data-number="3" href="#">Región de Atacama</a></li>
                                <li><a data-number="4" href="#">Región de Coquimbo</a></li>
                            </ul>
                            <ul class="col-md-4">
                                <li><strong>Zona Centro</strong></li>
                                <li><a data-number="5" href="#">Región de Valparaíso</a></li>
                                <li><a data-number="13" href="#">Región Metropolitana de Santiago</a></li>
                                <li><a data-number="6" href="#">Región del Libertador General Bernardo O´Higgins</a></li>
                                <li><a data-number="7" href="#">Región del Maule</a></li>
                            </ul>
                            <ul class="col-md-4">
                                <li><strong>Zona Sur</strong></li>
                                <li><a data-number="16" href="#">Región de Ñuble</a></li>
                                <li><a data-number="8" href="#">Región del Biobío</a></li>
                                <li><a data-number="9" href="#">Región de la Araucanía</a></li>
                                <li><a data-number="14" href="#">Región de Los Ríos</a></li>
                                <li><a data-number="10" href="#">Región de los Lagos</a></li>
                                <li><a data-number="11" href="#">Región de Aysén del General Carlos Ibáñez del Campo</a></li>
                                <li><a data-number="12" href="#">Región de Magallanes y de la Antártica</a></li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
<form action="/Home/BusquedaLicitacion" id="formRubroRegion" method="post">                <div id="dvCategoryResults">

                    <div class="row">
    <div>

        <div>
                <div class="col-sm-4 rubros-grilla">
                    <div class="row">
                        <div class="col-md-5 text-right">
                            <h2 class="highlighted-text pri-color text-thin"> 112</h2>
                        </div>

                        <div class="col-md-7 highlighted-description no-padding-left">
                            <p class="text-black">Licitaciones publicadas</p>
                            <p><span class="secondary-color text-light">En rubro de </span><a href="#" class="text-bold" onclick="buscarRubroRegion(72131700);">Construcci&#243;n de obras civiles y infraestructuras</a></p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 rubros-grilla">
                    <div class="row">
                        <div class="col-md-5 text-right">
                            <h2 class="highlighted-text pri-color text-thin"> 53</h2>
                        </div>

                        <div class="col-md-7 highlighted-description no-padding-left">
                            <p class="text-black">Licitaciones publicadas</p>
                            <p><span class="secondary-color text-light">En rubro de </span><a href="#" class="text-bold" onclick="buscarRubroRegion(80141600);">Ventas y marketing</a></p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 rubros-grilla">
                    <div class="row">
                        <div class="col-md-5 text-right">
                            <h2 class="highlighted-text pri-color text-thin"> 50</h2>
                        </div>

                        <div class="col-md-7 highlighted-description no-padding-left">
                            <p class="text-black">Licitaciones publicadas</p>
                            <p><span class="secondary-color text-light">En rubro de </span><a href="#" class="text-bold" onclick="buscarRubroRegion(43231500);">Software de gesti&#243;n</a></p>
                        </div>
                    </div>
                </div>

            <div id="qRubroRegionHidden">
            </div>

        </div>

    </div>
</div>
<div class="row">
    <div class="col-xs-12 seccion-imagenes">
        <img src="/Home/Imagenes/NuevoHome/regiones-de-chile-13.png" alt="Región de Arica y Parinacota" />
    </div>
</div>;

                </div>
</form>


        </div>
    </section>
    <section class="container">
        <div class="row padding-lg">
            <div class="col-md-6 v-padding-right">
                <div class="border-right">
                    <h2 class="pri-color">¿Qué es Mercado Público?</h2>
                    <p class="margin-bottom-md">Mercado Público es la plataforma transaccional administrada por ChileCompra a través de la cuál más de 850 organismos públicos compran productos y servicios a empresas de todos los tamaños y de todo el país.</p>
                </div>
            </div>
            <div class="col-md-6 v-padding-left">
                <h2 class="pri-color">¿Quieres ser proveedor del Estado?</h2>
                <p class="margin-bottom-md">El primer paso para convertirte en proveedor(a) del Estado es inscribirte en nuestra plataforma <strong>Mercado Público</strong>. Es gratis y <strong>puedes hacerlo con tu Clave Única</strong>. <strong>Al inscribirte</strong> podrás participar de los distintos procesos de compra; saber qué, cómo y cuándo compran los servicios públicos y analizar ofertas ganadoras disponibles en la plataforma.</p>

                <a href="https://www.chilecompra.cl/mercadopublico-y-registro/" target="_blank" class="btn btn-xl btn-ghost">
                    Leer más
                    <span class="flecha-icono">
                        <svg class="icon-guideline-flecha-derecha-lg">
                            <use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-flecha-derecha-lg"></use>
                        </svg>
                    </span>
                </a>
            </div>
        </div>
    </section>
    <section class="light-background">
        <div class="container">
            <div class="row padding-lg special-height-section">
                <div class="col-md-6 col-sm-12 v-padding-right info-block">
                    <div class="border-right">
                        <h2 class="pri-color">¿Cómo me capacito en Compras Públicas?</h2>
                        <p class="margin-bottom-md">Tanto compradores de los organismos públicos como proveedores pueden acceder a una amplia oferta de capacitaciones gratuitas, donde aprenderán sobre el uso de la plataforma y a mejorar su gestión en las compras del Estado.</p>

                        <div class="row">
                            <a href="https://capacitacion.chilecompra.cl/mod/page/view.php?id=18633" target="_blank" class="btn btn-xl btn-ghost col-lg-5 col-xs-9">
                                Ver más
                                <span class="flecha-icono">
                                    <svg class="icon-guideline-flecha-derecha-lg">
                                        <use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-flecha-derecha-lg"></use>
                                    </svg>
                                </span>
                            </a>

                            <div class="col-lg-1 col-sm-1 col-xs-12"></div>

                            <a href="https://ayuda.mercadopublico.cl/" target="_blank" class="btn btn-xl btn-ghost col-lg-6 col-xs-9" style="padding: 12px 20px;">
                                Ir al Centro de Ayuda
                                <span class="flecha-icono">
                                    <svg class="icon-guideline-flecha-derecha-lg">
                                        <use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-flecha-derecha-lg"></use>
                                    </svg>
                                </span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 v-padding-left info-block">
                    <h2 class="pri-color">¿Quieres saber qué y cómo compra el Estado?</h2>
                    <p class="margin-bottom-md section-4">El Estado compra desde insumos médicos, materiales de oficina, tecnología, servicios de consultoría, hasta puentes y hospitales. Conoce más detalle en nuestro sitio de <strong>datos abiertos.</strong></p>

                    <div class="row">
                        <a href="https://datos-abiertos.chilecompra.cl/" target="_blank" class="btn btn-xl btn-ghost col-lg-5 col-xs-9">
                            Leer más
                            <span class="flecha-icono">
                                <svg class="icon-guideline-flecha-derecha-lg">
                                    <use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-flecha-derecha-lg"></use>
                                </svg>
                            </span>
                        </a>

                        <div class="col-lg-1 col-sm-1 col-xs-12"></div>

                        <a href="../../Home/Plandecompra?esNuevaHome=true" target="_blank" class="btn btn-xl btn-ghost col-lg-6 col-xs-9" style="padding: 12px 20px;">
                            Ver Plan de Compra
                            <span class="flecha-icono">
                                <svg class="icon-guideline-flecha-derecha-lg">
                                    <use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-flecha-derecha-lg"></use>
                                </svg>
                            </span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!--Ro se agrega nuevo link-->

    <section class="container">
        <div class="row">
            <div class="col-md-12 padding-lg text-center">
                <h2 class="pri-color">¿Quieres Conocer todo sobre Convenio  Marco?</h2>

                <p class="margin-bottom-md">

                    Los Convenios Marco son una modalidad de compra de bienes y servicios a través de un
                    <br>catálogo electrónico o tienda virtual. Conoce sobre los Convenios Marco vigentes, su
                    <br>funcionamiento y revisa el calendario de actividades donde te podrás contactar con
                    <br>ChileCompra a través de los jefes de producto.

                </p>

                <a id="link_home_mp" href="https://ayuda.mercadopublico.cl/portalayuda/categoria/?c=CATE-PROV1&s=CAT-PROV1-04" target="_blank" onclick="sacar_focus();" class="btn btn-xl btn-pri">Ver sección de ayuda</a>



            </div>
        </div>
    </section>

    <!--Ro se agrega nuevo link-->

    <hr>



    <section class="container">
        <div class="row">
            <div class="col-md-12 padding-lg text-center">
                <h2 class="pri-color">¿Quieres ser proveedor del Estado?</h2>
                    <a href="#" onclick="irCHP();" class="btn btn-xl btn-pri">Registrate aquí</a>
            </div>
        </div>
    </section>
    <section class="light-background">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center padding-md">
                    <div class="capsula">
                        <h2 class="pri-color">Licitaciones publicadas</h2>
                        <p class="margin-bottom-xs">Archivo descargable de <span id="descripcion-descargable">todas las licitaciones publicadas.</span></p>
                        <button onclick="location.href='https://www.mercadopublico.cl/Portal/att.ashx?id=5'" class="btn btn-xl btn-ghost">Descargar</button>
                    </div>
                </div>
                <div class="col-md-6 text-center padding-md">
                    <div class="capsula">
                        <h2 class="pri-color">Licitaciones 2 o menos ofertas</h2>
                        <p class="margin-bottom-xs">Porcentaje de licitaciones 2 o menos oferentes en el año.</p>
                        <a href="/Home/IndicadorDeGestion?esNuevaHome=true" target="_blank" class="btn btn-xl btn-ghost">Leer más<span class="flecha-icono"><svg class="icon-guideline-flecha-derecha-lg"><use xlink:href="../../Home/Content/Iconos/icons.svg#icon-guideline-flecha-derecha-lg"></use></svg></span></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<!-- Latest compiled and minified JavaScript -->
    <script type="text/javascript" src="/Home/Scripts/Home/BuscadorElasticHome2018.js?v=20250617125607"></script>
<script type="text/javascript" src="/Home/Scripts/Home/HomeNuevo2018.js?v=20250617125607"></script>

<script src="/Home/Content/bootstrap-3.4.1/js/bootstrap.min.js" ></script>
<script type="text/javascript" src="/Home/Scripts/popper.min.js"></script>
<script type="text/javascript" src="/Home/Scripts/jquery.autocomplete.min.js"></script>
<script type="text/javascript" src="/Home/Scripts/jquery.tokeninput.js"></script>
<script type="text/javascript" src="/Home/Scripts/jquery.defaultvalue.js"></script>
<script type="text/javascript" src="/Home/Scripts/fancybox/jquery.fancybox.js"></script>
<link rel="stylesheet" type="text/css" href="/Home/Scripts/fancybox/jquery.fancybox.css" />

<script type="text/javascript">

    function irBusquedaProveedor() {
        var url = "/Autenticacion/Registro";
        $.ajax({
            type: "GET",
            url: url,
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (result) {
                var urlext = 'https://proveedor.mercadopublico.cl/busqueda/callback?access_token={0}&expires_in=28800'.format(result.access_token);
                window.location.href = urlext;
            },
            error: function (xhr, status, error) {
                alert('Ha ocurrido un error. Favor intente nuevamente.');
            }
        });
    }

    if (!String.prototype.format) {
        String.prototype.format = function () {
            var args = arguments;
            return this.replace(/{(\d+)}/g, function (match, number) {
                return typeof args[number] != 'undefined'
                    ? args[number]
                    : match
                    ;
            });
        };
    }

    function sacar_focus(urlext)
    {

        elemento = document.getElementById("link_home_mp");
        elemento.blur();
        //window.open = ("https://ayuda.mercadopublico.cl/portalayuda/categoria/?c=CATE-PROV1&s=CAT-PROV1-04", '_blank');
    }

</script>




        

        <footer role="contentinfo">
            <div class="footer-bottom hidden-print" style="background-color: #001C44;">
                <div class="container-fluid">
                    <div class="row" style="width: 90%; margin: 0 auto;">
                        <div class="col-md-2 col-sm-12 col-xs-12 text-left logo-container">
                            <img src="/Home/Imagenes/LogoChc.png" class="img-logo" alt="Imagen corporativa de Chilecompra" />
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12 text-left footer-item">
                            <ul class="list-unstyled">
                                <li style="font-weight: bold;">Dirección ChileCompra</li>
                                <li>Ministerio de Hacienda, Gobierno de Chile</li>
                                <li>Monjitas 392 - Piso 8, Santiago de Chile</li>
                                <li class="underline"><a href="http://www.chilecompra.cl/terminos-y-condiciones-de-uso/">Términos y condiciones</a></li>
                            </ul>
                        </div>
                        <div class="col-md-3 col-sm-12 col-xs-12 footer-item">
                            <ul class="list-unstyled sites">
                                <li style="font-weight: bold;">Sitios relacionados</li>
                                    <li style="font-size: 16px; color: white;" class="underline"><a href="https://comprador.mercadopublico.cl/registrarme">Registro nuevos organismos compradores</a></li>
                                <li style="font-size: 16px; color: white;" class="underline"><a href="https://datos-abiertos.chilecompra.cl/">Datos Abiertos ChileCompra</a></li>
                                <li style="font-size: 16px; color: white;" class="underline"><a href="https://capacitacion.chilecompra.cl/mod/page/view.php?id=18633">Capacitación</a></li>
                                <li style="font-size: 16px; color: white;" class="underline"><a href="https://ayuda.mercadopublico.cl/">Centro de Ayuda</a></li>
                            </ul>
                        </div>
                        <div class="col-md-2 col-sm-12 col-xs-12 text-left footer-item">
                            <ul class="list-unstyled help-desk">
                                <li style="font-weight: bold;">Mesa de ayuda</li>
                                <li>
                                    <p class="sc-kdBRUi gxQmdN MuiTypography-root MuiTypography-body2 sc-esYjtY jXwSoa">
                                        <a href="tel:6007000600" class="sx-kCMLfs boRzmn custom-link">600 7000 600</a>
                                    </p>
                                </li>
                                <li>
                                    <p class="sc-kdBRUi gxQmdN MuiTypography-root MuiTypography-body2 sc-esYjtY jXwSoa">
                                        <a href="tel:+56442360646" class="sx-kCMLfs boRzmn custom-link">+56 4 4236 0646</a>
                                    </p>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-2 col-sm-12 col-xs-12 text-left footer-item">
                            <ul class="list-unstyled">
                                <li style="font-weight: bold; padding-left:10px;">Síguenos</li>
                                <li>
                                    <ul class="list-unstyled" style="display: inline-flex">
                                        <li>
                                            <a href="https://www.facebook.com/people/ChileCompra/100064656435287/" target="_blank">
                                                <span id="pie_facebook" class="pie_columna_social" title="Facebook de ChileCompra"></span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="https://twitter.com/chilecompra" target="_blank">
                                                <span id="pie_twitter" class="pie_columna_social" title="Twitter de ChileCompra"></span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="https://cl.linkedin.com/company/chilecompra" target="_blank">
                                                <span id="pie_linkedin" class="pie_columna_social" title="Linkedin de ChileCompra"></span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="https://www.youtube.com/user/chilecompratv" target="_blank">
                                                <span id="pie_youtube" class="pie_columna_social" title="Youtube"></span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="https://www.instagram.com/chilecompra/" target="_blank">
                                                <span id="pie_instagram" class="pie_columna_social" title="Instagram de ChileCompra"></span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li id="serverAlias"><!-- Alias servidor --></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

    <script src="/Home/Scripts/modernizr.custom.39322.js"></script>

    <script src="/Home/Scripts/bootstrap.js"></script>

    <script type="text/javascript" src="/Home/Scripts/datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="/Home/Scripts/datepicker/js/locales/bootstrap-datepicker.es.js"></script>
    <script src="/Home/Scripts/popupmodal/popModal.js"></script>

    <script src="/Home/Scripts/smartmenus-0.9.7/jquery.smartmenus.js"></script>
<script src="/Home/Scripts/smartmenus-0.9.7/addons/bootstrap/jquery.smartmenus.bootstrap.js"></script>

    <script src="/Home/Scripts/Home/Home.js?v=202506171256" type="text/javascript"></script>
    <script src="/Home/Scripts/cssPopUp.js" type="text/javascript"></script>
    <!--popUpCambioContraseña-->
    <div id="blanket" style="display: none;" onclick="popup('popUpDiv')">
    </div>
    <div id="popUpDiv" style="display: none;">
        <table>
            <tr>
                <td>
                    <iframe id="ifrmCambioContrasena" runat="server" frameborder="0" style="width: 410px;
                        height: 370px;" scrolling="no"></iframe>
                </td>
                <td style="vertical-align: top;">
                    &nbsp; <b>
                        <a id="hpClose" href="#" onclick="popup('popUpDiv')" style="font-size: 20px;
                        color: #000000;">x</a>
                    </b>
                </td>
            </tr>
        </table>
        <div id="divButton" runat="server" style="display: none;">
        </div>
    </div>
    <!--popUpCambioContraseña-->
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-562013905503ab5f" async="async"></script>

    <script type="text/javascript">
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
                m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-51338325-2', 'auto');
        ga('send', 'pageview');
    </script>
    <script type="text/javascript" src="/Home/Content/Terminos/js/demo.js"></script>
    <script type="text/javascript" src="/Home/Content/Terminos/js/jquery.autocomplete.js"></script>
    <script type="text/javascript" src="/Home/Content/Terminos/js/jquery.mockjax.js"></script>
    <script type="text/javascript" src="/Home/Content/Terminos/js/modernizr.js"></script>
    <script type="text/javascript" src="/Home/Content/Terminos/js/teminos.js"></script>
    <script type="text/javascript" src="/Home/Scripts/script.js"></script>
    <script type="text/javascript" src="/Home/Scripts/svg4everybody.min.js"></script>


    <script type="text/javascript">
        svg4everybody(); // Se inicializa el soporte para IE
    </script>

        <script id="ccScriptComponent" type="text/javascript" src="https://www.mercadopublico.cl/Elementos/Scripts/chilecompra.componentes.js"></script>
        <script type="text/javascript">
            // "privado"
            $.iniciarComponentes({
                cargarContraste: true,
                cargarBarra: true,
                cargarFooter: true,
                opcionesFooter: {
                    tipoFooter: TipoFooterEnum.Publico,
                    quitarLinkFooterPublico: 1,
                    home2018: true
                },
                opcionesBarra: {
                    mercadoPublico: true,
                    chileCompra: true,
                    chileProveedores: true,
                    sitiosRelacionados: true,
                    capacitacion: true,
                    link: LinkEnum.ServicioAlUsuario,
                    aumentar: true,
                    disminuir: true,
                    altoContraste: true
                }
            });

        </script>
    
    <script type="text/javascript">
        $('.buscador-header').find('select').on('focus', function () {
            $(this).css('color', '#3d3d3d');
        }).on('focusout', function () {
            $(this).css('color', '#D6D6D6');
        });
    </script>

    <script type="text/javascript">
        function irCHP() {
            var url = "/Autenticacion/Registro";
            $.ajax({
                type: "GET",
                url: url,
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (result) {
                    var urlext = 'https://proveedor.mercadopublico.cl/registrarme';
                    window.location.href = urlext;
                },
                error: function (xhr, status, error) {
                    alert('Ha ocurrido un error. Favor intente nuevamente.');
                }
            });
        }
    </script>
    <script type="text/javascript">
        function pagoSinLogin() {
            var urlext = 'https://proveedor.mercadopublico.cl/pago/buscarProveedor';
            window.location.href = urlext;
        }
    </script>
    <script type="text/javascript" src="/Home/Scripts/datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="/Home/Scripts/datepicker/js/locales/bootstrap-datepicker.es.js"></script>
    <script type="text/javascript" src="/Home/Scripts/jquery.tokeninput.js"></script>
    <script type="text/javascript" src="/Home/Scripts/jquery.defaultvalue.js"></script>
    <script type="text/javascript" src="/Home/Scripts/fancybox/jquery.fancybox.js"></script>
    <script type="text/javascript" src="/Home/Scripts/RecuperacionContrasena/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/Home/Scripts/RecuperacionContrasena/easyResponsiveTabs.js"></script>
    <script src="https://rum-static.pingdom.net/pa-63190934405b1d00110012af.js" async></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: "/Elementos/Server/Get",
                type: 'GET',
                dataType: 'json',
                success: function (response) {
                    if (response.aliasServidor) {
                        $("#serverAlias").text("(" + response.aliasServidor + ")");
                    } else {
                        console.log("Error: No se recibió el alias del servidor.");
                    }
                },
                error: function (xhr, status, error) {
                    console.log("Error: " + error);
                }
            });
        });
    </script>
    <div class="modal fade" id="modalSpecialBlock" role="dialog" tabindex="-1" aria-hidden="true" runat="server" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-xs" role="document">
            <div class="modal-content">

                <div class="modal-body text-center pt-0 pb-2 pt-5">
                    <div class="icon-wrapper icon-wrapper-warning mx-auto mb-3">
                        <div class="icon-container">
                            <span class="material-icons-round" style="color: #f7c137; font-size:30px;">warning</span>
                        </div>
                    </div>
                    <span style="font-size:18px; font-weight:bold;" id="modalSpecialBlock_title"></span>
                    <p class="p-4" id="modalSpecialBlock_msj">

                    </p>

                </div>
                <div class="text-center pb-5 mt-0">
                    <button type="button" class="btn btn-chilecompra btn-default py-2" style="width: 150px;" data-dismiss="modal">
                        Cerrar
                    </button>
                </div>
            </div>
        </div>
    </div>

        <!-- Start of Rocket.Chat Livechat Script -->
        <script src="https://cfg-bot-ui.mercadopublico.cl/widget-logic.js" async></script>

    </body>
</html>

