<#macro renderNavbar applicationReportIndexModel index_page=false navUrlPrefix="">
    <div class="pf-c-page__header-nav">
        <nav class="pf-c-nav pf-m-horizontal"
             aria-label="Nav"
             data-ouia-component-type="PF4/Nav"
             data-ouia-safe="true"
             data-ouia-component-id="OUIA-Generated-Nav-horizontal-1"
        >
            <ul class="pf-c-nav__list">
                <#if applicationReportIndexModel??>
                <#-- This is for adding Application List link aka index.html-->
                    <#if !index_page!false>
                        <li class="pf-c-nav__item"
                            data-ouia-component-type="PF4/NavItem"
                            data-ouia-safe="true"
                            data-ouia-component-id="OUIA-Generated-NavItem-1">
                            <a href="../index.html"
                               class="pf-c-nav__link"
                               aria-current="page">
                                <i class="fas fa-home" aria-hidden="true"></i>&nbsp;
                                All Applications
                            </a>
                        </li>
                    <#else>
                        <li class="pf-c-nav__item"
                            data-ouia-component-type="PF4/NavItem"
                            data-ouia-safe="true"
                            data-ouia-component-id="OUIA-Generated-NavItem-1">
                            <a href="#"
                               class="pf-c-nav__link pf-m-current"
                               aria-current="page">
                                <i class="fas fa-home" aria-hidden="true"></i>&nbsp;
                                All Applications
                            </a>
                        </li>
                    </#if>

                    <#list applicationReportIndexModel.applicationReportModelsSortedByPriority as navReportModel>
                        <#if navReportModel.displayInApplicationReportIndex && navReportModel.reportFilename??>
                            <#assign liClass = "">
                            <#assign reportUrl = navReportModel.reportFilename>
                            <#if navUrlPrefix??>
                                <#assign reportUrl = "${navUrlPrefix}${reportUrl}">
                            </#if>

                            <#if reportModel?? && reportModel.equals(navReportModel) >
                                <#assign liClass = "pf-m-current">
                                <#assign reportUrl = "#">
                            </#if>

                            <li class="pf-c-nav__item"
                                data-ouia-component-type="PF4/NavItem"
                                data-ouia-safe="true"
                                data-ouia-component-id="OUIA-Generated-NavItem-2">
                                <a href="${reportUrl}" class="pf-c-nav__link ${liClass}">
                                    <#if navReportModel.reportIconClass?has_content>
                                        <i class="${navReportModel.reportIconClass}"></i>&nbsp;
                                    </#if>
                                    ${navReportModel.reportName}
                                </a>
                            </li>
                        </#if>
                    </#list>
                </#if>
            </ul>
        </nav>
    </div>
    <div class="pf-c-page__header-tools">
        <div class="pf-c-page__header-tools-group pf-m-hidden pf-m-visible-on-lg">
            <div class="pf-c-page__header-tools-item">
                <#include "userfeedback.ftl">
            </div>
        </div>
        <div class="pf-c-page__header-tools-group">
            <div class="pf-c-page__header-tools-item pf-m-hidden-on-lg">
                <#include "userfeedback.ftl">
            </div>
        </div>
    </div>
</#macro>

<#macro renderNavbarJavaScript index_page=false>
    <script type="text/javascript" style="display: none">
        var script = document.createElement("script");
        script.type = "text/javascript";
        <#if index_page>
        script.src = "reports/resources/js/navbar.js";
        <#else>
        script.src = "resources/js/navbar.js";
        </#if>
        document.body.appendChild(script);
    </script>
</#macro>