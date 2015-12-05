def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  formatron_grafana_dashboard "#{name} instance" do
    model(
      'tags' => [],
      'style' => 'dark',
      'timezone' => 'browser',
      'editable' => true,
      'hideControls' => false,
      'sharedCrosshair' => false,
      'rows' => [
        {
          'collapse' => false,
          'editable' => true,
          'height' => '250px',
          'panels' => [
            {
              'aliasColors' => {},
              'bars' => false,
              'datasource' => 'graphite',
              'editable' => true,
              'error' => false,
              'fill' => 1,
              'grid' => {
                'leftLogBase' => 1,
                'leftMax' => nil,
                'leftMin' => nil,
                'rightLogBase' => 1,
                'rightMax' => nil,
                'rightMin' => nil,
                'threshold1' => nil,
                'threshold1Color' => 'rgba(216, 200, 27, 0.27)',
                'threshold2' => nil,
                'threshold2Color' => 'rgba(234, 112, 112, 0.22)'
              },
              'id' => 1,
              'legend' => {
                'avg' => false,
                'current' => false,
                'max' => false,
                'min' => false,
                'show' => true,
                'total' => false,
                'values' => false
              },
              'lines' => true,
              'linewidth' => 2,
              'links' => [],
              'nullPointMode' => 'null as zero',
              'percentage' => false,
              'pointradius' => 5,
              'points' => false,
              'renderer' => 'flot',
              'seriesOverrides' => [
                {}
              ],
              'span' => 12,
              'stack' => true,
              'steppedLine' => false,
              'targets' => [
                {
                  'refId' => 'B',
                  'target' => "#{name}.user_percent.mem.*"
                }
              ],
              'timeFrom' => nil,
              'timeShift' => nil,
              'title' => 'Memory percent by user',
              'tooltip' => {
                'shared' => true,
                'value_type' => 'cumulative'
              },
              'type' => 'graph',
              'x-axis' => true,
              'y-axis' => true,
              'y_formats' => [
                'short',
                'short'
              ]
            }
          ],
          'title' => 'Row'
        },
        {
          'collapse' => false,
          'editable' => true,
          'height' => '250px',
          'panels' => [
            {
              'aliasColors' => {},
              'bars' => false,
              'datasource' => 'graphite',
              'editable' => true,
              'error' => false,
              'fill' => 1,
              'grid' => {
                'leftLogBase' => 1,
                'leftMax' => nil,
                'leftMin' => nil,
                'rightLogBase' => 1,
                'rightMax' => nil,
                'rightMin' => nil,
                'threshold1' => nil,
                'threshold1Color' => 'rgba(216, 200, 27, 0.27)',
                'threshold2' => nil,
                'threshold2Color' => 'rgba(234, 112, 112, 0.22)'
              },
              'id' => 3,
              'legend' => {
                'avg' => false,
                'current' => false,
                'max' => false,
                'min' => false,
                'show' => true,
                'total' => false,
                'values' => false
              },
              'lines' => true,
              'linewidth' => 2,
              'links' => [],
              'nullPointMode' => 'null as zero',
              'percentage' => false,
              'pointradius' => 5,
              'points' => false,
              'renderer' => 'flot',
              'seriesOverrides' => [],
              'span' => 12,
              'stack' => false,
              'steppedLine' => false,
              'targets' => [
                {
                  'refId' => 'A',
                  'target' => "#{name}.cpu.idle"
                }
              ],
              'timeFrom' => nil,
              'timeShift' => nil,
              'title' => 'CPU idle',
              'tooltip' => {
                'shared' => true,
                'value_type' => 'cumulative'
              },
              'type' => 'graph',
              'x-axis' => true,
              'y-axis' => true,
              'y_formats' => [
                'short',
                'short'
              ]
            }
          ],
          'title' => 'New row'
        },
        {
          'collapse' => false,
          'editable' => true,
          'height' => '250px',
          'panels' => [
            {
              'aliasColors' => {},
              'bars' => false,
              'datasource' => 'graphite',
              'editable' => true,
              'error' => false,
              'fill' => 1,
              'grid' => {
                'leftLogBase' => 1,
                'leftMax' => nil,
                'leftMin' => nil,
                'rightLogBase' => 1,
                'rightMax' => nil,
                'rightMin' => nil,
                'threshold1' => nil,
                'threshold1Color' => 'rgba(216, 200, 27, 0.27)',
                'threshold2' => nil,
                'threshold2Color' => 'rgba(234, 112, 112, 0.22)'
              },
              'id' => 2,
              'legend' => {
                'avg' => false,
                'current' => false,
                'max' => false,
                'min' => false,
                'show' => true,
                'total' => false,
                'values' => false
              },
              'lines' => true,
              'linewidth' => 2,
              'links' => [],
              'nullPointMode' => 'null as zero',
              'percentage' => false,
              'pointradius' => 5,
              'points' => false,
              'renderer' => 'flot',
              'seriesOverrides' => [],
              'span' => 12,
              'stack' => true,
              'steppedLine' => false,
              'targets' => [
                {
                  'refId' => 'A',
                  'target' => "#{name}.user_percent.cpu.*"
                }
              ],
              'timeFrom' => nil,
              'timeShift' => nil,
              'title' => 'CPU by user',
              'tooltip' => {
                'shared' => true,
                'value_type' => 'cumulative'
              },
              'type' => 'graph',
              'x-axis' => true,
              'y-axis' => true,
              'y_formats' => [
                'short',
                'short'
              ]
            }
          ],
          'title' => 'New row'
        }
      ],
      'time' => {
        'from' => 'now-12h',
        'to' => 'now'
      },
      'timepicker' => {
        'now' => true,
        'refresh_intervals' => [
          '5s',
          '10s',
          '30s',
          '1m',
          '5m',
          '15m',
          '30m',
          '1h',
          '2h',
          '1d'
        ],
        'time_options' => [
          '5m',
          '15m',
          '1h',
          '6h',
          '12h',
          '24h',
          '2d',
          '7d',
          '30d'
        ]
      },
      'templating' => {
        'list' => []
      },
      'annotations' => {
        'list' => []
      },
      'schemaVersion' => 7,
      'links' => []
        )
  end
end
