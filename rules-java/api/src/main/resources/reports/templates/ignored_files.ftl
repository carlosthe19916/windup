<!DOCTYPE html>
<html lang="en">

<#assign applicationReportIndexModel = reportModel.applicationReportIndexModel>

<#macro tagRenderer tag>
    <#if tag.level?? && tag.level == "IMPORTANT">
        <span class="label label-danger">
    <#else>
        <span class="label label-info">
    </#if>
        <#nested/></span>
</#macro>


<#macro ignoredFileRenderer reportModel>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Ignored Files</h3>
        </div>
        <table class="table table-striped table-bordered">
            <tr>
                <th>File</th>
                <th>Path</th>
                <th>Ignored Reason</th>
            </tr>

            <#list reportModel.ignoredFiles as file>
            <tr>
                <td> <#if file.fileName?has_content> ${file.fileName} </#if> </td>
                <td> <#if file.filePath?has_content> ${file.filePath} </#if> </td>
                <td> <#if file.ignoredRegex?has_content> ${file.ignoredRegex} </#if> </td>
            </tr>
            </#list>
        </table>
    </div>
</#macro>


<#macro fileRegexesRenderer reportModel>
    <#if reportModel.fileRegexes?has_content>
        <div class="panel panel-primary">
            <table class="table table-striped table-bordered">
                <tr>
                    <th>Regex</th>
                    <th>Compilable</th>
                </tr>

                <#list reportModel.fileRegexes as regex>
                <tr>
                    <td>${regex.regex!""}</td>
                    <td>${regex.compilationError!"OK"}</td>
                </tr>
                </#list>
            </table>
        </div>
    </#if>
</#macro>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${reportModel.projectModel.name} - Ignored Files</title>
    <link href="resources/css/patternfly/patternfly.min.css" rel="stylesheet"/>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="resources/css/font-awesome.min.css" rel="stylesheet" />
    <link href="resources/css/windup.css" rel="stylesheet" media="screen">
    <link href="resources/css/windup.java.css" rel="stylesheet" media="screen">
    <link href="resources/img/mta-icon.png" rel="shortcut icon" type="image/x-icon"/>

    <script src="resources/js/jquery-3.3.1.min.js"></script>
</head>
<body role="document">

<#include "include/page-init.ftl">

<section class="pf-c-page__main-section pf-m-light">
    <div class="pf-c-content">
        <h1>
            Ignored Files
            <#if reportModel.projectModel??>
                :&nbsp;${reportModel.projectModel.rootFileModel.applicationName}
            </#if>
        </h1>
        <p>${reportModel.description}</p>
    </div>
</section>

<section class="pf-c-page__main-section">
    <div class="container-fluid" role="main">
        <div class="row">
            <div class="container-fluid theme-showcase" role="main">
                <@fileRegexesRenderer reportModel />
                <@ignoredFileRenderer reportModel />
            </div>
        </div>

        <#include "include/timestamp.ftl">
    </div> <!-- /container -->
</section>

<#include "include/page-end.ftl">


    <script src="resources/libraries/flot/jquery.flot.min.js"></script>
    <script src="resources/libraries/flot/jquery.flot.pie.min.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
    <script>$(document).ready(function(){$('[data-toggle="tooltip"]').tooltip();});</script>
</body>
</html>
