import React from "react";
import {
  PageHeader,
  Brand,
  PageHeaderTools,
  Avatar,
  PageHeaderToolsGroup,
  PageHeaderToolsItem,
  Button,
  ButtonVariant,
} from "@patternfly/react-core";
import { HelpIcon } from "@patternfly/react-icons";

import { AppAboutModalState } from "../AppAboutModalState";
import { MobileDropdown } from "./MobileDropdown";

import navBrandImage from "./logo-navbar.svg";
import imgAvatar from "./avatar.svg";
import { SidebarApp } from "..";

export const HeaderApp: React.FC = () => {
  const headerTools = (
    <PageHeaderTools>
      <PageHeaderToolsGroup
        visibility={{
          default: "hidden",
          lg: "visible",
        }} /** the settings and help icon buttons are only visible on desktop sizes and replaced by a kebab dropdown for other sizes */
      >
        <PageHeaderToolsItem>
          <AppAboutModalState>
            {({ toggleModal }) => {
              return (
                <Button
                  id="aboutButton"
                  aria-label="about-button"
                  variant={ButtonVariant.plain}
                  onClick={toggleModal}
                >
                  <HelpIcon />
                </Button>
              );
            }}
          </AppAboutModalState>
        </PageHeaderToolsItem>
      </PageHeaderToolsGroup>
      <PageHeaderToolsGroup>
        <PageHeaderToolsItem
          visibility={{
            lg: "hidden",
          }} /** this kebab dropdown replaces the icon buttons and is hidden for desktop sizes */
        >
          <MobileDropdown />
        </PageHeaderToolsItem>
      </PageHeaderToolsGroup>
      <Avatar src={imgAvatar} alt="Avatar image" />
    </PageHeaderTools>
  );

  return (
    <PageHeader
      logo={<Brand src={navBrandImage} alt="Logo" />}
      logoProps={{
        href: "/",
      }}
      headerTools={headerTools}
      topNav={<SidebarApp />}
    />
  );
};
