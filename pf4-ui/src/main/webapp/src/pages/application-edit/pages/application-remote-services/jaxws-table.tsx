import React, { useMemo, useState } from "react";

import {
  Button,
  ButtonVariant,
  Modal,
} from "@patternfly/react-core";
import { IAction, ICell, IRow } from "@patternfly/react-table";
import {
  SimpleTableWithToolbar,
  useModal,
  useTable,
  useTableControls,
} from "@project-openubl/lib-ui";

import { JaxWsServiceDto } from "@app/api/application-remote-services";
import { useFilesQuery } from "@app/queries/files";
import { useRemoteServicesQuery } from "@app/queries/remote-services";
import { FileEditor } from "@app/shared/components";

const DataKey = "DataKey";

const columns: ICell[] = [
  {
    title: "Interface",
    transforms: [],
    cellTransforms: [],
  },
  {
    title: "Implementation",
    transforms: [],
    cellTransforms: [],
  },
];

export interface IJaxWsTableProps {
  applicationId: string;
}

export const JaxWsTable: React.FC<IJaxWsTableProps> = ({ applicationId }) => {
  // Filters
  const [filterText] = useState("");

  // Queries
  const allFiles = useFilesQuery();
  const allRemoteServicesQuery = useRemoteServicesQuery();

  const beans = useMemo(() => {
    return (
      allRemoteServicesQuery.data?.find(
        (f) => f.applicationId === applicationId
      )?.jaxWsServices || []
    );
  }, [allRemoteServicesQuery.data, applicationId]);

  // file editor
  const fileModal = useModal<"showFile", string>();
  const fileModalMappedFile = useMemo(() => {
    return allFiles.data?.find((file) => file.id === fileModal.data);
  }, [allFiles.data, fileModal.data]);

  // Rows
  const {
    page: currentPage,
    sortBy: currentSortBy,
    changePage: onPageChange,
    changeSortBy: onChangeSortBy,
  } = useTableControls();

  const { pageItems, filteredItems } = useTable<JaxWsServiceDto>({
    items: beans,
    currentPage: currentPage,
    currentSortBy: currentSortBy,
    compareToByColumn: () => 0,
    filterItem: (item) => true,
  });

  const itemsToRow = (items: JaxWsServiceDto[]) => {
    const rows: IRow[] = [];
    items.forEach((item) => {
      rows.push({
        [DataKey]: item,
        cells: [
          {
            title: item.interfaceFileId ? (
              <Button
                variant={ButtonVariant.link}
                isInline
                onClick={() => fileModal.open("showFile", item.interfaceFileId)}
              >
                {item.interfaceName}
              </Button>
            ) : (
              item.interfaceName
            ),
          },
          {
            title: item.implementationFileId ? (
              <Button
                variant={ButtonVariant.link}
                isInline
                onClick={() =>
                  fileModal.open("showFile", item.implementationFileId)
                }
              >
                {item.implementationName}
              </Button>
            ) : (
              item.implementationName
            ),
          },
        ],
      });
    });

    return rows;
  };

  const rows: IRow[] = itemsToRow(pageItems);
  const actions: IAction[] = [];

  return (
    <>
      <SimpleTableWithToolbar
        hasTopPagination
        hasBottomPagination
        totalCount={filteredItems.length}
        // Sorting
        sortBy={currentSortBy || { index: undefined, defaultDirection: "asc" }}
        onSort={onChangeSortBy}
        // Pagination
        currentPage={currentPage}
        onPageChange={onPageChange}
        // Table
        rows={rows}
        cells={columns}
        actions={actions}
        // Fech data
        isLoading={allRemoteServicesQuery.isFetching}
        loadingVariant="skeleton"
        fetchError={allRemoteServicesQuery.isError}
        // Toolbar filters
        filtersApplied={filterText.trim().length > 0}
      />
      <Modal
        title={`File ${fileModalMappedFile?.prettyPath}`}
        isOpen={fileModal.isOpen && fileModal.action === "showFile"}
        onClose={fileModal.close}
        variant="default"
        position="top"
        disableFocusTrap
        actions={[
          <Button key="close" variant="primary" onClick={fileModal.close}>
            Close
          </Button>,
        ]}
      >
        {fileModalMappedFile && <FileEditor file={fileModalMappedFile} />}
      </Modal>
    </>
  );
};
