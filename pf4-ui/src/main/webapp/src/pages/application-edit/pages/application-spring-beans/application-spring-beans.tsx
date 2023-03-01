import React from "react";
import { useOutletContext } from "react-router-dom";

import { PageSection } from "@patternfly/react-core";

import { ApplicationDto } from "@app/api/application";

import { SpringBeansTable } from "./spring-beans-table";

export const ApplicationSpringBeans: React.FC = () => {
  const application = useOutletContext<ApplicationDto | null>();

  return (
    <>
      <PageSection>
        {application?.id && (
          <SpringBeansTable applicationId={application?.id} />
        )}
      </PageSection>
    </>
  );
};
