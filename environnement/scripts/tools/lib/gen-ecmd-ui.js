function generateEcmdUI(functionTab) {

    let output = '';
    let sep = '';


    const groupedFunctions = functionTab.reduce((acc, { functionName, ecmdMeta }) => {
        if (!acc[ecmdMeta.group]) {
          acc[ecmdMeta.group] = [];
        }
        acc[ecmdMeta.group].push({ functionName, ecmdMeta });
        return acc;
      }, {});
    
    output += `
      [
    `;
      Object.keys(groupedFunctions).forEach(group => {
        output += `
           {
            "group": "${group}",
            "links": [
        `;
        groupedFunctions[group].forEach(({ functionName, ecmdMeta }) => {
          output += `
            { "id": 700, "name": "${functionName}", "url": "http://localhost:${ecmdMeta.port}" },
          `;
        });

        output += `
            ]
            },
        `;
      });

      output += `
        ]
    `;

    return output;
}

module.exports = { generateEcmdUI };


