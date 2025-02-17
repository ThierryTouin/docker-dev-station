function generateEcmdUI(functionTab) {
  const groupedFunctions = functionTab.reduce((acc, { functionName, ecmdMeta }) => {
      if (!acc[ecmdMeta.group]) {
          acc[ecmdMeta.group] = [];
      }
      acc[ecmdMeta.group].push({ functionName, ecmdMeta });
      return acc;
  }, {});

  const output = Object.keys(groupedFunctions).map(group => ({
      group,
      links: groupedFunctions[group].map(({ functionName, ecmdMeta }) => ({
          id: 700,
          name: functionName,
          url: `http://localhost:${ecmdMeta.port}`
      }))
  }));

  return JSON.stringify(output, null, 2); // Mise en forme avec indentation
}

module.exports = { generateEcmdUI };
