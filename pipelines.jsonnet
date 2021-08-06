local workspaces = (import 'workspaces.json').workspaces;

local plan_job(script, ws) = {
  command: script + ws,
  key: 'plan-' + ws,
  label: 'plan-' + ws,
};

local apply_job(script, ws) = {
  command: [script + ws],
  depends_on: ['plan-' + ws],
};

local pipeline(ws) = {
  [ws]: {
    steps: [
      plan_job('echo terraform plan-', ws),
      // { block: 'apply-' + ws },
      apply_job('echo terraform apply-', ws),
    ],
  },
};

local generate_pipelines(pipelines) =
  local append(arr, i, res) =
    if i >= std.length(arr) then
      res
    else
      append(arr, i + 1, res + arr[i]) tailstrict;
  append(pipelines, 0, {});

{} + generate_pipelines([pipeline(ws) for ws in workspaces])
