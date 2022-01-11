<!DOCTYPE html>

<#assign applicationReportIndexModel = reportModel.applicationReportIndexModel>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>${reportModel.projectModel.name} - ${reportModel.reportProperties.embeddedTitle}</title>
    <link href="resources/css/patternfly/patternfly.min.css" rel="stylesheet"/>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="resources/css/font-awesome.min.css" rel="stylesheet" />
    <link href="resources/css/windup.css" rel="stylesheet" media="screen"/>
    <link href="resources/img/mta-icon.png" rel="shortcut icon" type="image/x-icon"/>

    <script src="resources/js/jquery-3.3.1.min.js"></script>
</head>
<body role="document">

<#include "include/page-init.ftl">

<section class="pf-c-page__main-section pf-m-light">
    <div class="container-fluid" role="main">
        <div class="row">
            <div class="page-header page-header-no-border">
                <h1>
                    <div class="main">${reportModel.reportName}
                        <i class="glyphicon glyphicon-info-sign" data-toggle="tooltip" data-placement=right title="${reportModel.description}"></i></div>
                        <#if reportModel.projectModel??>
                            <div class="path">${reportModel.projectModel.rootFileModel.applicationName}</div>
                        </#if>
                </h1>
            </div>
        </div>

        <div class="row">
                <iframe style="width:100%; height: 100%; position:absolute;border-width: 0px;padding-left: 15px;padding-right: 15px;" src="${reportModel.reportProperties.embeddedUrl}"></iframe>
        </div>
    </div>
</section>

<#include "include/page-end.ftl">

    <script src="resources/js/bootstrap.min.js"></script>
</body>
</html>
