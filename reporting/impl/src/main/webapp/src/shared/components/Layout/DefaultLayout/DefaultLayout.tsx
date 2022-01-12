import React from "react";
import { Page, SkipToContent } from "@patternfly/react-core";
import { HeaderApp } from "../HeaderApp";

export interface DefaultLayoutProps {}

export const DefaultLayout: React.FC<DefaultLayoutProps> = ({ children }) => {
  const pageId = "main-content-page-layout-horizontal-nav";

  return (
    <React.Fragment>
      <Page
        mainContainerId={pageId}
        skipToContent={
          <SkipToContent href={`#${pageId}`}>Skip to content</SkipToContent>
        }
        header={<HeaderApp />}
      >
        {children}
      </Page>
    </React.Fragment>
  );
};
